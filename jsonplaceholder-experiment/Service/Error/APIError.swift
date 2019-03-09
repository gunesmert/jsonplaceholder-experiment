//
//  APIError.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import Foundation

struct APIError: Decodable {
	var description: String
	
	var localizedDescription: String {
		return "API error"
	}
}
