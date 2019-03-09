//
//  NetworkClientError.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import Foundation

enum NetworkClientErrorType {
	case apiError(APIError)
	case invalidURL(String)
	case invalidResponse(URLResponse?, Data?)
	case noInternetConnection
	case unauthorized
	case unknownError
	
	var localizedDescription: String {
		switch self {
		case .apiError(let error):
			return error.localizedDescription
		default:
			return "An unknown error occurred. Please try again."
		}
	}
}

class NetworkClientError: NSObject, LocalizedError {
	let type: NetworkClientErrorType
	
	init(type: NetworkClientErrorType) {
		self.type = type
	}
	
	override var description: String {
		return type.localizedDescription
	}
	
	var errorDescription: String? {
		return description
	}
}
