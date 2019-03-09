//
//  BaseTableViewController.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import UIKit
import SnapKit

class BaseTableViewController: BaseViewController {
	let componentsView = BaseComponentsView()
	
	// MARK: - View Lifecycle
	override func loadView() {
		super.loadView()
		view.addSubview(componentsView)
		componentsView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
		if canPullToRefresh {
			componentsView.tableView.addSubview(refreshControl)
		}
	}
	
	// MARK: - Refresh
	lazy var refreshControl: UIRefreshControl = {
		let control = UIRefreshControl()
		control.tintColor = ColorPalette.Primary.tint
		return control
	}()
	
	var canPullToRefresh: Bool { return false }
	
	// MARK: - Helper Methods
	func register<T: UITableViewCell>(_ cell: T) {
		componentsView.tableView.register(T.self, forCellReuseIdentifier: T.identifier)
	}
	
	func registerHeaderFooterView<T: UITableViewHeaderFooterView & StaticallyIdentifiable>(_ view: T) {
		componentsView.tableView.register(T.self, forHeaderFooterViewReuseIdentifier: T.identifier)
	}
}
