//
//  ViewModelProtocol.swift
//  PershinTestApp
//
//  Created by Sergey Pershin on 08.04.2021.
//

import Foundation



class BaseViewModel {
    var showAlert:((AlertViewModel) -> ())?
    var showActionSheet:((AlertViewModel) -> ())?
    var isLoading: ((Bool) -> ())?
}
