//
//  TableViewModelProtocol.swift
//  PershinTestApp
//
//  Created by Sergey Pershin on 08.04.2021.
//

import Foundation


protocol TableViewModelProtocol {
    func numberOfSections() -> Int
    func numberOfRows(in: Int) -> Int
    func cellModel(for: IndexPath) -> CellViewModelProtocol?
    
    var reloadDataEvent: ObservableEvent { get }
}



protocol CollectionViewModelProtocol {
    func numberOfSections() -> Int
    func numberOfRows(in: Int) -> Int
    func cellModel(for: IndexPath) -> CollectionCellViewModelProtocol?
    
    var reloadDataEvent: ObservableEvent { get }
}
