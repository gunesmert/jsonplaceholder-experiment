//
//  BaseViewController.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
	lazy var disposeBag = DisposeBag()
	
	// MARK: - Initializers
	required init?(coder aDecoder: NSCoder) {
		preconditionFailure("init(coder:) has not been implemented")
	}
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	// MARK: - View Lifecycle
	override func loadView() {
		super.loadView()
		view.backgroundColor = ColorPalette.Primary.background
	}
}
