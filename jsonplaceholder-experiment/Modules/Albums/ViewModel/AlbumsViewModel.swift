//
//  AlbumsViewModel.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import RxSwift
import RxCocoa

protocol AlbumsViewModel {
	var inputs: AlbumsViewModelInputs { get }
	var outputs: AlbumsViewModelOutputs { get }
}

final class DefaultAlbumsViewModel: AlbumsViewModel {
	weak var delegate: AlbumsViewModelDelegate?
	
	private let repository: Repository
	
	var inputs: AlbumsViewModelInputs { return self }
	var outputs: AlbumsViewModelOutputs { return self }
	
	private var fetchedAlbums: [Album] = [] {
		didSet {
			albumsInput.onNext(fetchedAlbums)
		}
	}
	
	private lazy var albumsInput = BehaviorSubject<[Album]>(value: [])
	private let albumsReloadInput: PublishSubject<()> = PublishSubject()
	private var componentsViewStateInput = BehaviorSubject<BaseComponentsViewState>(value: .idle)
	
	private let disposeBag = DisposeBag()
	
	init(with repository: Repository) {
		self.repository = repository
		
		let fetchAlbums = albumsReloadInput.flatMap { bundle in
			self.repository.fetchAlbums()
				.asObservable()
				.materialize()
			}.share()
		
		fetchAlbums.elements().map { items in
			return items
			}.subscribe(onNext: { albums in
				DispatchQueue.main.async { [weak self] in
					self?.fetchedAlbums(albums)
				}
			}).disposed(by: disposeBag)
		
		fetchAlbums.errors().map { error in
			return error
			}.subscribe(onNext: { error in
				DispatchQueue.main.async { [weak self] in
					self?.receivedError(error)
				}
			}).disposed(by: disposeBag)
	}
	
	// MARK: - Helper Methods
	private func fetchAlbums() {
		fetchedAlbums = []
		componentsViewStateInput.onNext(.loading)
		albumsReloadInput.onNext(())
	}
	
	private func receivedError(_ error: Error) {
		let message = error.localizedDescription + NSLocalizedString("\nPlease tap to try again.", comment: "")
		let state = BaseComponentsViewState.error(message)
		componentsViewStateInput.onNext(state)
	}
	
	private func fetchedAlbums(_ albums: [Album]) {
		fetchedAlbums = albums
		componentsViewStateInput.onNext(.idle)
	}
}

// MARK: - Protocols
enum AlbumsViewModelDelegateAction {
	case didSelectAlbum(Album)
}

protocol AlbumsViewModelDelegate: class {
	func albumsViewModel(_ viewModel: AlbumsViewModel, didTrigger action: AlbumsViewModelDelegateAction)
}

// MARK: - AlbumsViewModelInputs
protocol AlbumsViewModelInputs {
	func refreshAlbums()
	func selectedRecord(at indexPath: IndexPath)
}

extension DefaultAlbumsViewModel: AlbumsViewModelInputs {
	func refreshAlbums() {
		fetchAlbums()
	}
	
	func selectedRecord(at indexPath: IndexPath) {
		guard indexPath.row < fetchedAlbums.count else { return }
		let album = fetchedAlbums[indexPath.row]
		let action = AlbumsViewModelDelegateAction.didSelectAlbum(album)
		delegate?.albumsViewModel(self, didTrigger: action)
	}
}

// MARK: - AlbumsViewModelOutputs
protocol AlbumsViewModelOutputs {
	var albums: Observable<[Album]> { get }
	var componentsViewState: Observable<BaseComponentsViewState> { get }
}

extension DefaultAlbumsViewModel: AlbumsViewModelOutputs {
	var albums: Observable<[Album]> { return albumsInput.asObservable() }
	var componentsViewState: Observable<BaseComponentsViewState> { return componentsViewStateInput.asObservable() }
}
