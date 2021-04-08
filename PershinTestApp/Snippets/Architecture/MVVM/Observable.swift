//
//  Observable.swift
//  PershinTestApp
//
//  Created by Sergey Pershin on 08.04.2021.
//

import Foundation


class Observable<T> {

    typealias Handler = (T) -> Void
    
    var value: T {
        didSet {
            self.handlers.forEach { $0(self.value) }
        }
    }

    private var handlers = [Handler]()

    init(_ value: T) {
        self.value = value
    }

    func bind(_ handler: @escaping Handler) {
        handler(self.value)
        self.handlers.append(handler)
    }
    
}
