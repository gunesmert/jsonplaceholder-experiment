//
//  MaterializedExtensions.swift
//  jsonplaceholder-experiment
//
//  Created by Mert Ahmet Güneş on 2019-03-09.
//  Copyright © 2019 mertahmetgunes. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType where E: EventConvertible {
	/**
	Returns an observable sequence containing only next elements from its input
	- seealso: [materialize operator on reactivex.io](http://reactivex.io/documentation/operators/materialize-dematerialize.html)
	*/
	public func elements() -> Observable<E.ElementType> {
		return filter { $0.event.element != nil }
			.map { $0.event.element! }
	}
	
	/**
	Returns an observable sequence containing only error elements from its input
	- seealso: [materialize operator on reactivex.io](http://reactivex.io/documentation/operators/materialize-dematerialize.html)
	*/
	public func errors() -> Observable<Swift.Error> {
		return filter { $0.event.error != nil }
			.map { $0.event.error! }
	}
}
