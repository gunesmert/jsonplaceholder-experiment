//
//  AlbumCell.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import UIKit
import SnapKit

struct AlbumCellTextAttributes {
	public static var headline: [NSAttributedString.Key: Any] {
		var attributes = [NSAttributedString.Key: Any]()
		attributes[NSAttributedString.Key.font] = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
		attributes[NSAttributedString.Key.foregroundColor] = ColorPalette.Secondary.tint
		return attributes
	}
}

final class AlbumCell: UITableViewCell {
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
		
		contentView.addSubview(titleLabel)
		titleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(LayoutConstants.verticalMargin)
			make.leading.trailing.equalToSuperview().inset(LayoutConstants.horizontalMargin)
			make.bottom.equalToSuperview().inset(LayoutConstants.verticalMargin).priority(999)
		}
	}
}

// MARK: - Layout Constants
private extension AlbumCell {
	struct LayoutConstants {
		static var verticalMargin: CGFloat = 20.0
		static var horizontalMargin: CGFloat = Constants.defaultMargin
	}
}

// MARK: - Configuration
extension AlbumCell {
	func configure(with album: Album) {
		titleLabel.attributedText = NSAttributedString(string: album.title,
													   attributes: AlbumCellTextAttributes.headline)
	}
}
