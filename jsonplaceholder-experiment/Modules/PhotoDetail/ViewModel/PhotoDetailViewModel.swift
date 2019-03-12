//
//  PhotoDetailViewModel.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-12.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import RxSwift
import RxCocoa

protocol PhotoDetailViewModel {
	var inputs: PhotoDetailViewModelInputs { get }
	var outputs: PhotoDetailViewModelOutputs { get }
}

final class DefaultPhotoDetailViewModel: PhotoDetailViewModel {
	var inputs: PhotoDetailViewModelInputs { return self }
	var outputs: PhotoDetailViewModelOutputs { return self }
	
	private var photoInput = PublishSubject<Photo>()
	private let originalPhoto: Photo
	
	// MARK: - Constructors
	init(with photo: Photo) {
		self.originalPhoto = photo
	}
}

// MARK: - PhotoDetailViewModelInputs
protocol PhotoDetailViewModelInputs {
	func viewDidLoad()
}

extension DefaultPhotoDetailViewModel: PhotoDetailViewModelInputs {
	func viewDidLoad() {
		photoInput.onNext(originalPhoto)
	}
}

// MARK: - PhotoDetailViewModelOutputs
protocol PhotoDetailViewModelOutputs {
	var photo: Observable<Photo> { get }
}

extension DefaultPhotoDetailViewModel: PhotoDetailViewModelOutputs {
	var photo: Observable<Photo> { return photoInput.asObservable() }
}
