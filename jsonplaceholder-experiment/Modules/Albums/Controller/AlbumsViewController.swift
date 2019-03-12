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

final class AlbumsViewController: BaseTableViewController {
	private let viewModel: AlbumsViewModel
	
	override var canPullToRefresh: Bool {
		return true
	}
	
	private var albums: [Album] = [] {
		didSet {
			componentsView.tableView.reloadData()
			refreshControl.endRefreshing()
		}
	}
	
	// MARK: - Initializers
	required init?(coder aDecoder: NSCoder) {
		preconditionFailure("init(coder:) has not been implemented")
	}
	
	init(viewModel: AlbumsViewModel) {
		self.viewModel = viewModel
		super.init()
		setupInterface()
	}
	
	// MARK: - View Lifecycle
	override func loadView() {
		super.loadView()
		view.backgroundColor = ColorPalette.Primary.background
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		bind(to: viewModel)
		viewModel.inputs.refreshAlbums()
	}
}

// MARK: - ViewModel
private extension AlbumsViewController {
	private func bind(to viewModel: AlbumsViewModel) {
		viewModel.outputs.componentsViewState
			.subscribe(
				onNext: { [weak self] state in
					self?.componentsView.state = state
					self?.refreshControl.endRefreshing()
				}
			)
			.disposed(by: disposeBag)
		
		viewModel.outputs.albums
			.subscribe(
				onNext: { [weak self] albums in
					self?.albums = albums
				}
			)
			.disposed(by: disposeBag)
	}
}

// MARK: - Configuration
private extension AlbumsViewController {
	private func setupInterface() {
		self.title = NSLocalizedString("Albums", comment: "")
		
		componentsView.tableView.register(AlbumCell.self,
										  forCellReuseIdentifier: AlbumCell.identifier)
		componentsView.tableView.delegate = self
		componentsView.tableView.dataSource = self
		componentsView.tableView.estimatedRowHeight = UITableView.automaticDimension
		componentsView.delegate = self
		
		refreshControl.addTarget(self,
								 action: #selector(refresh(_:)),
								 for: .valueChanged)
	}
	
	private func configure(_ cell: AlbumCell, forRowAt indexPath: IndexPath) {
		guard indexPath.row < albums.count else { return }
		let album = albums[indexPath.row]
		cell.configure(with: album)
	}
}

// MARK: - UITableViewDataSource
extension AlbumsViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return albums.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumCell.identifier,
													   for: indexPath) as? AlbumCell else {
														return UITableViewCell()
		}
		configure(cell, forRowAt: indexPath)
		return cell
	}
}

// MARK: - UITableViewDelegate
extension AlbumsViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		viewModel.inputs.selectedRecord(at: indexPath)
	}
}

// MARK: - BaseComponentsViewDelegate
extension AlbumsViewController: BaseComponentsViewDelegate {
	func emptyStateViewDidReceiveTap(_ view: BaseComponentsView) {
		viewModel.inputs.refreshAlbums()
	}
}

// MARK: - Refresh
private extension AlbumsViewController {
	@objc func refresh(_ control: UIRefreshControl) {
		viewModel.inputs.refreshAlbums()
	}
}
