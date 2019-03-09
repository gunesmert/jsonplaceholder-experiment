//
//  NetworkHelpers.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import Foundation

enum HttpMethod: String {
	case get
	case post
	case put
	case delete
	case patch
	case head
	
	var value: String {
		return self.rawValue.uppercased()
	}
}
