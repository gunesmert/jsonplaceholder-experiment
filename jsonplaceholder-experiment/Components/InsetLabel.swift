//
//  InsetLabel.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import UIKit

final class InsetLabel: UILabel {
	var insets = UIEdgeInsets.zero
	
	internal override func drawText(in rect: CGRect) {
		super.drawText(in: rect.inset(by: insets))
	}
	
	override var intrinsicContentSize: CGSize {
		var contentSize = super.intrinsicContentSize
		contentSize.height += (insets.top + insets.bottom)
		contentSize.height = ceil(contentSize.height)
		contentSize.width += (insets.left + insets.right)
		return contentSize
	}
}
