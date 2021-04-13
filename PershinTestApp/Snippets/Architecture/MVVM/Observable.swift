//
//  Observable.swift
//  PershinTestApp
//
//  Created by Sergey Pershin on 08.04.2021.
//

import Foundation


typealias ObservableEvent = Observable<Void>

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
        self.handlers.append(handler)
    }
}


extension Observable where T == Void {
    convenience init() {
        self.init(())
    }
    
    func fire() {
        self.value = ()
    }
}
