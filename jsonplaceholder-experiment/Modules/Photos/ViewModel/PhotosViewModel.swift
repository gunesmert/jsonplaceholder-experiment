//
//  PhotosViewModel.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-10.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import RxSwift
import RxCocoa

protocol PhotosViewModel {
	var inputs: PhotosViewModelInputs { get }
	var outputs: PhotosViewModelOutputs { get }
}

final class DefaultPhotosViewModel: PhotosViewModel {
	weak var delegate: PhotosViewModelDelegate?
	
	private let repository: Repository
	private let album: Album
	
	var inputs: PhotosViewModelInputs { return self }
	var outputs: PhotosViewModelOutputs { return self }
	
	private var fetchedPhotos: [Photo] = [] {
		didSet {
			photosInput.onNext(fetchedPhotos)
		}
	}
	
	private lazy var photosInput = BehaviorSubject<[Photo]>(value: [])
	private let photosReloadInput: PublishSubject<Album> = PublishSubject()
	private var componentsViewStateInput = BehaviorSubject<BaseComponentsViewState>(value: .idle)
	
	private let disposeBag = DisposeBag()
	
	init(with repository: Repository, and album: Album) {
		self.repository = repository
		self.album = album
		
		let fetchPhotos = photosReloadInput.flatMap { album in
			self.repository.fetchPhotos(of: album)
				.asObservable()
				.materialize()
			}.share()
		
		fetchPhotos.elements().map { items in
			return items
			}.subscribe(onNext: { photos in
				DispatchQueue.main.async { [weak self] in
					self?.fetchedPhotos(photos)
				}
			}).disposed(by: disposeBag)
		
		fetchPhotos.errors().map { error in
			return error
			}.subscribe(onNext: { error in
				DispatchQueue.main.async { [weak self] in
					self?.receivedError(error)
				}
			}).disposed(by: disposeBag)
	}
	
	// MARK: - Helper Methods
	private func fetchPhotos() {
		componentsViewStateInput.onNext(.loading)
		photosReloadInput.onNext(album)
	}
	
	private func receivedError(_ error: Error) {
		let state = BaseComponentsViewState.error(error.localizedDescription)
		componentsViewStateInput.onNext(state)
	}
	
	private func fetchedPhotos(_ photos: [Photo]) {
		fetchedPhotos = photos
		componentsViewStateInput.onNext(.idle)
	}
}

// MARK: - Protocols
enum PhotosViewModelDelegateAction {
	case didSelectPhoto(Photo)
}

protocol PhotosViewModelDelegate: class {
	func photosViewModel(_ viewModel: PhotosViewModel, didTrigger action: PhotosViewModelDelegateAction)
}

// MARK: - PhotosViewModelInputs
protocol PhotosViewModelInputs {
	func refreshPhotos()
	func selectedRecord(at indexPath: IndexPath)
}

extension DefaultPhotosViewModel: PhotosViewModelInputs {
	func refreshPhotos() {
		fetchPhotos()
	}
	
	func selectedRecord(at indexPath: IndexPath) {
		guard indexPath.row < fetchedPhotos.count else { return }
		let photo = fetchedPhotos[indexPath.row]
		let action = PhotosViewModelDelegateAction.didSelectPhoto(photo)
		delegate?.photosViewModel(self, didTrigger: action)
	}
}

// MARK: - PhotosViewModelOutputs
protocol PhotosViewModelOutputs {
	var photos: Observable<[Photo]> { get }
	var componentsViewState: Observable<BaseComponentsViewState> { get }
}

extension DefaultPhotosViewModel: PhotosViewModelOutputs {
	var photos: Observable<[Photo]> { return photosInput.asObservable() }
	var componentsViewState: Observable<BaseComponentsViewState> { return componentsViewStateInput.asObservable() }
}
