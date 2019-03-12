//
//  MainNavigationController.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import UIKit

private struct NavigationBarTextAttributes {
	public static var regular: [NSAttributedString.Key: Any] {
		var attributes = [NSAttributedString.Key: Any]()
		attributes[NSAttributedString.Key.font] = UIFont.preferredFont(forTextStyle: .headline)
		attributes[NSAttributedString.Key.foregroundColor] = ColorPalette.Primary.tint
		return attributes
	}
	
	public static var large: [NSAttributedString.Key: Any] {
		var attributes = [NSAttributedString.Key: Any]()
		attributes[NSAttributedString.Key.font] = UIFont.preferredFont(forTextStyle: .largeTitle)
		attributes[NSAttributedString.Key.foregroundColor] = ColorPalette.Primary.tint
		return attributes
	}
}

final class MainNavigationController: BaseNavigationController {
	// MARK: - Constructors
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(rootViewController: UIViewController) {
		super.init(rootViewController: rootViewController)
		
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		navigationBar.prefersLargeTitles = true
		navigationItem.largeTitleDisplayMode = .automatic
		
		navigationBar.largeTitleTextAttributes = NavigationBarTextAttributes.large
		navigationBar.titleTextAttributes = NavigationBarTextAttributes.regular
	
		navigationBar.barTintColor = ColorPalette.Primary.background
	}
}
