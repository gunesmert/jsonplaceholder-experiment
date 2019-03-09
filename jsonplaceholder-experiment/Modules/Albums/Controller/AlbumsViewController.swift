//
//  AlbumsViewController.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class AlbumsViewController: BaseViewController {
	private let viewModel: AlbumsViewModel
	
	// MARK: - Initializers
	required init?(coder aDecoder: NSCoder) {
		preconditionFailure("init(coder:) has not been implemented")
	}
	
	init(viewModel: AlbumsViewModel) {
		self.viewModel = viewModel
		super.init()
	}
}
