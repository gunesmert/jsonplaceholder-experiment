//
//  Album.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import Foundation

struct Album: Decodable {
	let userId: Int64
	let id: Int64
	let title: String
}
