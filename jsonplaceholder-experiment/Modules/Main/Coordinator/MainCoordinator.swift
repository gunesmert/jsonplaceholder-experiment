//
//  MainCoordinator.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import UIKit

final class MainCoordinator: Coordinator {
	lazy private(set) var viewController: UIViewController = {
		return navigationController
	}()
	
	private lazy var navigationController: MainNavigationController = {
		let controller = MainNavigationController(rootViewController: rootViewController)
		return controller
	}()
	
	private lazy var rootViewController: UIViewController = {
		let controller = UIViewController()
		controller.view.backgroundColor = UIColor.red
		return controller
	}()
}
