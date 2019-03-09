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
	case photos	= "/albums/%d/photos"
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
		let path = String(format: Path.photos.rawValue, album.id)
		let endpoint = DefaultAPIEndpoint(path: path,
										  httpMethod: HttpMethod.get)
		return networkClient.fetch(endpoint)
	}
}
