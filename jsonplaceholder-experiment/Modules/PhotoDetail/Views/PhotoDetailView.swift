//
//  PhotoDetailView.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-12.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

final class PhotoDetailView: UIView {
	private lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		return imageView
	}()
	
	private lazy var descriptionLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .body)
		label.textColor = ColorPalette.Secondary.tint
		label.numberOfLines = 0
		return label
	}()
	
	// MARK: - Constructors
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupInterface()
	}
}

// MARK: - Layout Setup
private extension PhotoDetailView {
	struct LayoutConstants {
		static var defaultMargin: CGFloat = 16.0
		static var imageDimension: CGFloat = 200.0
	}
	
	func setupInterface() {
		addSubview(imageView)
		addSubview(descriptionLabel)
		
		layoutConstraints()
	}
	
	func layoutConstraints() {
		imageView.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(LayoutConstants.defaultMargin)
			make.size.equalTo(CGSize(width: LayoutConstants.imageDimension,
									 height: LayoutConstants.imageDimension))
			make.leading.equalToSuperview().inset(LayoutConstants.defaultMargin)
		}
		
		descriptionLabel.snp.makeConstraints { make in
			make.top.equalTo(imageView.snp.bottom).inset(-LayoutConstants.defaultMargin)
			make.leading.bottom.trailing.equalToSuperview().inset(LayoutConstants.defaultMargin)
		}
	}
}

// MARK: - Configuration
extension PhotoDetailView {
	func configure(with photo: Photo) {
		imageView.image = nil
		
		if let url = URL(string: photo.url) {
			imageView.kf.setImage(with: url)
		}
		
		descriptionLabel.text = photo.title
	}
}
