//
//  BaseNavigationController.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationBar.tintColor = ColorPalette.Secondary.tint
	}
	
	// MARK: - Status Bar
	override var childForStatusBarStyle: UIViewController? {
		return topViewController
	}
	
	override var childForStatusBarHidden: UIViewController? {
		return topViewController
	}
}
