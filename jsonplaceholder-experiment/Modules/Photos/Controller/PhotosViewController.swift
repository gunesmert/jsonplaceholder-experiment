//
//  PhotosViewController.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-10.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class PhotosViewController: BaseTableViewController {
	private let viewModel: PhotosViewModel
	
	override var canPullToRefresh: Bool {
		return true
	}
	
	private var photos: [Photo] = [] {
		didSet {
			componentsView.tableView.reloadData()
		}
	}
	
	// MARK: - Initializers
	required init?(coder aDecoder: NSCoder) {
		preconditionFailure("init(coder:) has not been implemented")
	}
	
	init(viewModel: PhotosViewModel) {
		self.viewModel = viewModel
		super.init()
		self.title = NSLocalizedString("Photos", comment: "")
		
		componentsView.tableView.register(PhotoCell.self,
										  forCellReuseIdentifier: PhotoCell.identifier)
		componentsView.tableView.delegate = self
		componentsView.tableView.dataSource = self
		componentsView.tableView.estimatedRowHeight = UITableView.automaticDimension
	}
	
	// MARK: - View Lifecycle
	override func loadView() {
		super.loadView()
		view.backgroundColor = ColorPalette.Primary.background
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		bind(to: viewModel)
		viewModel.inputs.refreshPhotos()
	}
	
	// MARK: - ViewModel
	private func bind(to viewModel: PhotosViewModel) {
		viewModel.outputs.componentsViewState
			.subscribe(
				onNext: { [weak self] state in
					self?.componentsView.state = state
				}
			)
			.disposed(by: disposeBag)
		
		viewModel.outputs.photos
			.subscribe(
				onNext: { [weak self] photos in
					self?.photos = photos
				}
			)
			.disposed(by: disposeBag)
	}
	
	// MARK: - Cell Configuration
	private func configure(_ cell: PhotoCell, forRowAt indexPath: IndexPath) {
		guard indexPath.row < photos.count else { return }
		let photo = photos[indexPath.row]
		cell.configure(with: photo)
	}
}

// MARK: - UITableViewDataSource
extension PhotosViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return photos.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.identifier,
													   for: indexPath) as? PhotoCell else {
														return UITableViewCell()
		}
		configure(cell, forRowAt: indexPath)
		return cell
	}
}

// MARK: - UITableViewDelegate
extension PhotosViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		viewModel.inputs.selectedRecord(at: indexPath)
	}
	
	func tableView(_ tableView: UITableView,
				   didEndDisplaying cell: UITableViewCell,
				   forRowAt indexPath: IndexPath) {
		guard let cell = cell as? PhotoCell else { return }
		cell.cancelDownloadIfNeeded()
	}
}
