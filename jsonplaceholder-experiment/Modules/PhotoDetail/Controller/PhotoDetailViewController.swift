//
//  PhotoDetailViewController.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-12.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import UIKit
import RxSwift

final class PhotoDetailViewController: BaseScrollViewController {
	private let viewModel: PhotoDetailViewModel
	private let detailView = PhotoDetailView()
	
	// MARK: - Initializers
	required init?(coder aDecoder: NSCoder) {
		preconditionFailure("init(coder:) has not been implemented")
	}
	
	init(viewModel: PhotoDetailViewModel) {
		self.viewModel = viewModel
		super.init()
		self.title = NSLocalizedString("Photo Detail", comment: "")
	}
	
	// MARK: - View Lifecycle
	override func loadView() {
		super.loadView()
		view.backgroundColor = ColorPalette.Primary.background
		
		contentView.addSubview(detailView)
		detailView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		bind(to: viewModel)
		viewModel.inputs.viewDidLoad()
	}
}

// MARK: - ViewModel
private extension PhotoDetailViewController {
	private func bind(to viewModel: PhotoDetailViewModel) {
		viewModel.outputs.photo
			.subscribe(
				onNext: { [weak self] photo in
					self?.detailView.configure(with: photo)
				}
			)
			.disposed(by: disposeBag)
	}
}
