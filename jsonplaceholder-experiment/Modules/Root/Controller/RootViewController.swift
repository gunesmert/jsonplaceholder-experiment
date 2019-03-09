//
//  RootViewController.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import UIKit

final class RootViewController: BaseViewController {
	// MARK: - Status Bar
	override var childForStatusBarStyle: UIViewController? {
		return children.last
	}
	
	override var childForStatusBarHidden: UIViewController? {
		return children.last
	}
}

