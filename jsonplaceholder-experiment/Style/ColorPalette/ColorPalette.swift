//
//  ColorPalette.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import UIKit

public struct ColorPalette {
	public struct Primary {
		public static let tint = UIColor.paris
		public static let background = UIColor.seashell
	}
	
	public struct Secondary {
		public static let tint = UIColor.mediumPersianBlue
		public static let background = UIColor.loblolly
	}
}

// MARK: - Private Colors
extension UIColor {
	convenience init(hexString: String) {
		let hex = hexString.replacingOccurrences(of: "#", with: "")
		guard hex.count == 6, let hexValue = Int(hex, radix: 16) else {
			self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
			return
		}
		self.init(red:   CGFloat( (hexValue & 0xFF0000) >> 16 ) / 255.0,
				  green: CGFloat( (hexValue & 0x00FF00) >> 8 ) / 255.0,
				  blue:  CGFloat( (hexValue & 0x0000FF) >> 0 ) / 255.0,
				  alpha: 1.0)
	}
}

private extension UIColor {
	/*
	For color naming conventions, an app called `Sip` was used.
	Link: https://sipapp.io
	*/
	
	static var paris: UIColor {
		return UIColor(hexString: "#2F2859")
	}
	
	static var mediumPersianBlue: UIColor {
		return UIColor(hexString: "#0D669E")
	}
	
	static var seashell: UIColor {
		return UIColor(hexString: "#F2F2F2")
	}
	
	static var loblolly: UIColor {
		return UIColor(hexString: "#C1C8CC")
	}
}
