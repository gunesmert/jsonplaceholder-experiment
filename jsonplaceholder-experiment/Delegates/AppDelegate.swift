//
//  AppDelegate.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	
	private let rootCoordinator: RootCoordinator
	
	override init() {
		let urlString = "https://jsonplaceholder.typicode.com"
		let networkClient = DefaultNetworkClient(with: urlString)
		let apiClient = DefaultAPIClient(networkClient: networkClient)
		let repository = DefaultRepository(with: apiClient)
		
		self.rootCoordinator = RootCoordinator(with: repository)
		super.init()
	}
	
	func application(_ application: UIApplication,
					 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		initializeApplication()
		return true
	}
}

// MARK: - Initialize
private extension AppDelegate {
	func initializeApplication() {
		let window = UIWindow(frame: UIScreen.main.bounds)
		window.rootViewController = rootCoordinator.viewController
		window.makeKeyAndVisible()
		self.window = window
	}
}
