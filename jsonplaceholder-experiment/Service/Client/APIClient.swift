//
//  APIClient.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import Foundation
import RxSwift

protocol APIClient {
	func fetchAlbums() -> Single<Data>
	func fetchPhotos(of album: Album) -> Single<Data>
}

private enum Path: String {
	case albums	= "/albums"
	case photos	= "/photos"
}

struct DefaultAPIClient: APIClient {
	private let networkClient: NetworkClient
	
	init(networkClient: NetworkClient) {
		self.networkClient = networkClient
	}
	
	func fetchAlbums() -> Single<Data> {
		let endpoint = DefaultAPIEndpoint(path: Path.albums.rawValue,
										  httpMethod: HttpMethod.get)
		return networkClient.fetch(endpoint)
	}
	
	func fetchPhotos(of album: Album) -> Single<Data> {
		var queryParameters = [String: Any]()
		queryParameters["albumId"] = album.id
		
		let parameters = Parameters.query(queryParameters)
		let endpoint = DefaultAPIEndpoint(path: Path.photos.rawValue,
										  httpMethod: HttpMethod.get,
										  parameters: parameters,
										  headerParameters: nil)
		return networkClient.fetch(endpoint)
	}
}
