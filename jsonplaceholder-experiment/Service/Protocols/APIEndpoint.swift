//
//  APIEndpoint.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import Foundation

enum Parameters {
	case query([String: Any])
	case form([String: Any])
	case body(Any)
	case data(Data)
}

enum HeaderParameter {
	case contentType(String)
	case authorization(String)
	
	var key: String {
		switch self {
		case .contentType:
			return "Content-Type"
		case .authorization:
			return "Authorization"
		}
	}
	
	var value: String {
		switch self {
		case .contentType(let value):
			return value
		case .authorization(let value):
			return value
		}
	}
}

protocol APIEndpoint {
	var path: String { get }
	var httpMethod: HttpMethod { get }
	var parameters: Parameters? { get }
	var headerParameters: [HeaderParameter]? { get }
	
	init(path: String,
		 httpMethod: HttpMethod,
		 parameters: Parameters?,
		 headerParameters: [HeaderParameter]?)
}

struct DefaultAPIEndpoint: APIEndpoint {
	let path: String
	let httpMethod: HttpMethod
	let parameters: Parameters?
	var headerParameters: [HeaderParameter]?
	
	init(path: String,
		 httpMethod: HttpMethod,
		 parameters: Parameters? = nil,
		 headerParameters: [HeaderParameter]? = nil) {
		self.path = path
		self.httpMethod = httpMethod
		self.parameters = parameters
		self.headerParameters = headerParameters
	}
}
