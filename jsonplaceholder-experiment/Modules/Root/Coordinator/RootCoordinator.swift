//
//  RootCoordinator.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import UIKit
import SnapKit

final class RootCoordinator: Coordinator {
	private let repository: Repository
	private lazy var mainCoordinator = MainCoordinator(with: repository)
	
	lazy private(set) var viewController: UIViewController = {
		return RootViewController()
	}()
	
	// MARK: - Initializers
	init(with repository: Repository) {
		self.repository = repository
		activateMainCoordinator()
	}
	
	// MARK: - Coordination Methods
	private func addChildCoordinator(_ coordinator: Coordinator) {
		DispatchQueue.main.async { [weak self] in
			guard let strongSelf = self else { return }
			if strongSelf.viewController.children.contains(coordinator.viewController) { return }
			strongSelf.viewController.addChild(coordinator.viewController)
			strongSelf.viewController.view.addSubview(coordinator.viewController.view)
			coordinator.viewController.view.snp.makeConstraints { $0.edges.equalToSuperview() }
			coordinator.viewController.didMove(toParent: strongSelf.viewController)
		}
	}
	
	private func removeChildCoordinator(_ coordinator: Coordinator) {
		DispatchQueue.main.async {
			coordinator.viewController.willMove(toParent: nil)
			coordinator.viewController.view.removeFromSuperview()
			coordinator.viewController.removeFromParent()
		}
	}
	
	private func activateMainCoordinator() {
		addChildCoordinator(mainCoordinator)
	}
}
