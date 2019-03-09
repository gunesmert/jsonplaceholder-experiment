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
	private let repository: Repository
	
	var inputs: AlbumsViewModelInputs { return self }
	var outputs: AlbumsViewModelOutputs { return self }
	
	private lazy var albumsInput = BehaviorSubject<[Album]>(value: [])
	private let albumsReloadInput: PublishSubject<()> = PublishSubject()
	
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
				self.updatedAlbums(albums)
			}).disposed(by: disposeBag)
		
		fetchAlbums.errors().map { error in
			return error
			}.subscribe(onNext: { error in
				self.displayError(error)
			}).disposed(by: disposeBag)
		
		albumsReloadInput.onNext(())
	}
	
	// MARK: - Helper Methods
	private func displayError(_ error: Error) {
		print("")
	}
	
	private func updatedAlbums(_ albums: [Album]) {
		print("")
	}
}

// MARK: - AlbumsViewModelInputs
protocol AlbumsViewModelInputs {
	
}

extension DefaultAlbumsViewModel: AlbumsViewModelInputs {
	
}

// MARK: - AlbumsViewModelOutputs
protocol AlbumsViewModelOutputs {
	
}

extension DefaultAlbumsViewModel: AlbumsViewModelOutputs {
	
}
