//
//  NetworkClient.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import Foundation
import RxSwift

#if DEBUG
private var shouldShowLogs: Bool = true
#else
private var shouldShowLogs: Bool = false
#endif

protocol NetworkClient {
	var fetch: (APIEndpoint) -> Single<Data> { get }
}

struct DefaultNetworkClient: NetworkClient {
	let fetch: (APIEndpoint) -> Single<Data>
	
	init(with urlString: String) {
		self.fetch = { (endpoint) -> Single<Data> in
			return NetworkClientCommons
				.createRequest(with: urlString, andEndpoint: endpoint)
				.flatMap(NetworkClientCommons.performRequest)
				.flatMap(NetworkClientCommons.validateResponse)
		}
	}
}

// MARK: - NetworkClientCommons
enum NetworkClientCommons {
	static func createRequest(with urlString: String,
							  andEndpoint endpoint: APIEndpoint) -> Single<URLRequest> {
		return Single<URLRequest>.create { single in
			let adapter = DefaultAPIAdapter(with: urlString, andEndpoint: endpoint)
			guard let request = adapter.request else {
				single(.error(NetworkClientError(type: .invalidURL(endpoint.path))))
				return Disposables.create()
			}
			
			single(.success(request))
			return Disposables.create()
		}
	}
	
	static func validateResponse(_ responseAndData: (response: HTTPURLResponse, data: Data)) -> Single<Data> {
		let (response, data) = responseAndData
		
		if shouldShowLogs {
			if let dataString = String(data: data, encoding: String.Encoding.utf8) {
				print("\nDATA:\n\(dataString)\n")
			}
		}
		
		guard 200..<400 ~= response.statusCode else {
			if response.statusCode == 401 {
				return .error(NetworkClientError(type: .unauthorized))
			}
			
			if let error = try? JSONDecoder().decode(APIError.self, from: data) {
				return .error(NetworkClientError(type: .apiError(error)))
			}
			
			return .error(NetworkClientError(type: .invalidResponse(response, data)))
		}
		
		return .just(data)
	}
	
	static func performRequest(with request: URLRequest) -> Single<(response: HTTPURLResponse, data: Data)> {
		return Single<(response: HTTPURLResponse, data: Data)>.create { single in
			if shouldShowLogs {
				print("\nREQUEST:\n\(String(describing: request))\n")
			}
			
			let session = URLSession(configuration: URLSessionConfiguration.default,
									 delegate: nil,
									 delegateQueue: nil)
			
			let task = session.dataTask(with: request) { (data: Data?,
				response: URLResponse?,
				error: Error?) in
				if shouldShowLogs {
					print("\nRESPONSE:\n\(String(describing: response))\n")
				}
				
				if let error = error {
					let errorCode = (error as NSError).code
					
					if errorCode == -1009 {
						single(.error(NetworkClientError(type: .noInternetConnection)))
					} else {
						single(.error(error))
					}
					
					return
				}
				
				guard let HTTPResponse = response as? HTTPURLResponse else {
					single(.error(NetworkClientError(type: .invalidResponse(response, data))))
					return
				}
				
				single(SingleEvent<(response: HTTPURLResponse, data: Data)>.success((response: HTTPResponse,
																					 data: data ?? Data())))
			}
			task.resume()
			
			return Disposables.create { task.cancel() }
		}
	}
}
