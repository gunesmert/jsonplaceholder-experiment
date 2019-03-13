//
//  Repository.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import Foundation
import RxSwift

protocol Repository {
	func fetchAlbums() -> Single<[Album]>
	func fetchPhotos(of album: Album) -> Single<[Photo]>
}

final class DefaultRepository: Repository {
	let client: APIClient
	
	init(with client: APIClient) {
		self.client = client
	}
	
	func fetchAlbums() -> Single<[Album]> {
		return client.fetchAlbums().map {
			return try JSONDecoder().decode([Album].self, from: $0)
		}
	}
	
	func fetchPhotos(of album: Album) -> Single<[Photo]> {
		return client.fetchPhotos(of: album).map {
			return try JSONDecoder().decode([Photo].self, from: $0)
		}
	}
}

