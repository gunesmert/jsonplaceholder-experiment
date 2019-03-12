//
//  PhotoCell.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-10.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

struct PhotoCellTextAttributes {
	public static var title: [NSAttributedString.Key: Any] {
		var attributes = [NSAttributedString.Key: Any]()
		attributes[NSAttributedString.Key.font] = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
		attributes[NSAttributedString.Key.foregroundColor] = ColorPalette.Secondary.tint
		return attributes
	}
}

final class PhotoCell: UITableViewCell {
	private lazy var thumbnailImageView: UIImageView = {
		let imageView = UIImageView()
		return imageView
	}()
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		return label
	}()
	
	// MARK: - Initializers
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		selectionStyle = .none
		
		contentView.addSubview(thumbnailImageView)
		thumbnailImageView.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(LayoutConstants.verticalMargin)
			make.leading.equalToSuperview().inset(LayoutConstants.horizontalMargin)
			make.size.equalTo(CGSize(width: LayoutConstants.imageDimension,
									 height: LayoutConstants.imageDimension))
			make.bottom.equalToSuperview().inset(LayoutConstants.verticalMargin).priority(999)
		}
		
		contentView.addSubview(titleLabel)
		titleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(LayoutConstants.verticalMargin)
			make.leading.equalTo(thumbnailImageView.snp.trailing).inset(-LayoutConstants.horizontalSpacing)
			make.trailing.equalToSuperview().inset(LayoutConstants.horizontalMargin)
			make.bottom.equalToSuperview().inset(LayoutConstants.verticalMargin).priority(999)
		}
	}
}

// MARK: - Layout Constants
private extension PhotoCell {
	struct LayoutConstants {
		static var imageDimension: CGFloat = 50.0
		static var verticalMargin: CGFloat = 10.0
		static var horizontalMargin: CGFloat = Constants.defaultMargin
		static var horizontalSpacing: CGFloat = 20.0
	}
}

// MARK: - Configuration
extension PhotoCell {
	func configure(with photo: Photo) {
		titleLabel.attributedText = NSAttributedString(string: photo.title,
													   attributes: PhotoCellTextAttributes.title)
		
		thumbnailImageView.image = nil
		
		guard let url = URL(string: photo.thumbnailUrl) else { return }
		thumbnailImageView.kf.setImage(with: url)
	}
}
