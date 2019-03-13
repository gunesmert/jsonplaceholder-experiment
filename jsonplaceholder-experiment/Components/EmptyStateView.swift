//
//  EmptyStateView.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import UIKit
import SnapKit

enum EmptyStateMode {
	case noResults
	case custom(String)
	
	var information: String {
		switch self {
		case .noResults:
			return NSLocalizedString("No results", comment: "")
		case .custom(let message):
			return message
		}
	}
}

final class EmptyStateView: UIView {
	private lazy var illustrationImageView: UIImageView = {
		let image = UIImage(named: "illustration-sloth")?.withRenderingMode(.alwaysTemplate)
		let view = UIImageView(image: image)
		view.backgroundColor = ColorPalette.Primary.background
		view.contentMode = .center
		view.tintColor = ColorPalette.Secondary.tint
		return view
	}()
	
	private lazy var informationLabel: InsetLabel = {
		let label = InsetLabel()
		label.insets = UIEdgeInsets(top: Constants.defaultMargin,
									left: Constants.defaultMargin,
									bottom: Constants.defaultMargin,
									right: Constants.defaultMargin)
		label.font = UIFont.preferredFont(forTextStyle: .title3)
		label.textColor = ColorPalette.Secondary.tint
		label.textAlignment = .center
		label.numberOfLines = 0
		return label
	}()
	
	private lazy var contentView: UIStackView = {
		let view = UIStackView()
		view.distribution = .fillProportionally
		view.axis = .vertical
		view.spacing = Constants.defaultMargin
		return view
	}()
	
	var mode = EmptyStateMode.noResults {
		didSet {
			updateInterface(with: mode)
		}
	}
	
	var shouldShowImage: Bool = true {
		didSet {
			if shouldShowImage {
				if !contentView.arrangedSubviews.contains(illustrationImageView) {
					contentView.addArrangedSubview(illustrationImageView)
				}
			} else {
				contentView.removeArrangedSubview(illustrationImageView)
				illustrationImageView.removeFromSuperview()
			}
		}
	}
	
	// MARK: - Initializers
	required init?(coder aDecoder: NSCoder) {
		preconditionFailure("init(coder:) has not been implemented")
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		backgroundColor = ColorPalette.Primary.background
		
		addSubview(contentView)
		contentView.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview().inset(Constants.defaultMargin)
			make.centerY.equalToSuperview()
		}
		
		contentView.addArrangedSubview(illustrationImageView)
		contentView.addArrangedSubview(informationLabel)
	}
}

// MARK: - Configuration
extension EmptyStateView {
	private func updateInterface(with mode: EmptyStateMode) {
		informationLabel.text = mode.information
	}
}
