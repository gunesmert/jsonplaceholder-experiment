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

extension EmptyStateMode: Equatable {
	static func ==(lhs: EmptyStateMode, rhs: EmptyStateMode) -> Bool {
		switch (lhs, rhs) {
		case (.noResults, .noResults):
			return true
		case (.custom, .custom):
			return lhs.information == rhs.information
		default:
			return false
		}
	}
}

final class EmptyStateView: UIView {
	private lazy var illustrationImageView: UIImageView = {
		let image = UIImage(named: "illustration-sloth")
		let view = UIImageView(image: image)
		view.backgroundColor = UIColor.clear
		view.contentMode = UIView.ContentMode.center
		return view
	}()
	
	private lazy var informationLabel: InsetLabel = {
		let label = InsetLabel()
		label.insets = UIEdgeInsets(top: Constants.defaultMargin,
									left: Constants.defaultMargin,
									bottom: Constants.defaultMargin,
									right: Constants.defaultMargin)
		label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title3)
		label.textColor = ColorPalette.Primary.Light.text
		label.textAlignment = .center
		label.numberOfLines = 0
		return label
	}()
	
	private lazy var contentView: UIStackView = {
		let view = UIStackView()
		view.distribution = UIStackView.Distribution.fillProportionally
		view.axis = NSLayoutConstraint.Axis.vertical
		view.spacing = Constants.defaultMargin
		return view
	}()
	
	var mode = EmptyStateMode.noResults {
		didSet {
			updateInterface()
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
	
	// MARK: - Interface
	private func updateInterface() {
		informationLabel.text = mode.information
	}
}
