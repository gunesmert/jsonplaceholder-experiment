//
//  Photo.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import Foundation

struct Photo: Decodable {
	let albumId: Int64
	let id: Int64
	let title: String
	let url: String
	let thumbnailUrl: String
}
