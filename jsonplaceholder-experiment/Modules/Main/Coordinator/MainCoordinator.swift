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

// MARK: - AlbumsViewModelDelegate
extension MainCoordinator: AlbumsViewModelDelegate {
	func albumsModelView(_ viewModel: AlbumsViewModel,
						 didTrigger action: AlbumsViewModelDelegateAction) {
		switch action {
		case .didSelectAlbum:
			// TODO: Open Photos
			break
		}
	}
}
