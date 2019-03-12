//
//  BaseScrollViewController.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-12.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import UIKit
import SnapKit

class BaseScrollViewController: BaseViewController {
	lazy var scrollView: UIScrollView = {
		let view = UIScrollView()
		view.alwaysBounceVertical = true
		view.backgroundColor = UIColor.clear
		view.keyboardDismissMode = UIScrollView.KeyboardDismissMode.interactive
		return view
	}()
	
	lazy var contentView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.clear
		return view
	}()
	
	// MARK: - View Lifecycle
	override func loadView() {
		super.loadView()
		
		view.addSubview(scrollView)
		scrollView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
		scrollView.addSubview(contentView)
		contentView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
			make.leading.equalTo(view)
			make.trailing.equalTo(view)
		}
	}
}
