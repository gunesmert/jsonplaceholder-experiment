//
//  StaticallyIdentifiable.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import UIKit

protocol StaticallyIdentifiable {
	static var identifier: String { get }
}

extension StaticallyIdentifiable {
	static var identifier: String {
		return String(describing: self)
	}
}

extension UITableViewCell: StaticallyIdentifiable { }
