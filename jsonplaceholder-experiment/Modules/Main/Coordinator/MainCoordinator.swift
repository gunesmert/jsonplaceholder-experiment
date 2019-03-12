//
//  MainCoordinator.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import UIKit

final class MainCoordinator: Coordinator {
	private let repository: Repository
	
	lazy private(set) var viewController: UIViewController = {
		return navigationController
	}()
	
	private lazy var navigationController: MainNavigationController = {
		let controller = MainNavigationController(rootViewController: albumsViewController)
		return controller
	}()
	
	private lazy var albumsViewController: AlbumsViewController = {
		let viewModel = DefaultAlbumsViewModel(with: repository)
		viewModel.delegate = self
		let controller = AlbumsViewController(viewModel: viewModel)
		return controller
	}()
	
	// MARK: - Constructors
	init(with repository: Repository) {
		self.repository = repository
	}
}

// MARK: - Redirection
private extension MainCoordinator {
	func displayPhotos(of album: Album) {
		let viewModel = DefaultPhotosViewModel(with: repository, and: album)
		viewModel.delegate = self
		let controller = PhotosViewController(viewModel: viewModel)
		navigationController.pushViewController(controller, animated: true)
	}
}

// MARK: - PhotosViewModelDelegate
extension MainCoordinator: PhotosViewModelDelegate {
	func photosViewModel(_ viewModel: PhotosViewModel,
						 didTrigger action: PhotosViewModelDelegateAction) {
		switch action {
		case .didSelectPhoto:
			// TODO: Open Photo Detail
			break
		}
	}
}

// MARK: - AlbumsViewModelDelegate
extension MainCoordinator: AlbumsViewModelDelegate {
	func albumsViewModel(_ viewModel: AlbumsViewModel,
						 didTrigger action: AlbumsViewModelDelegateAction) {
		switch action {
		case .didSelectAlbum(let album):
			displayPhotos(of: album)
		}
	}
}
