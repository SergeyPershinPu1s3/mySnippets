//
//  ViewModelProtocol.swift
//  PershinTestApp
//
//  Created by Sergey Pershin on 08.04.2021.
//

import Foundation



protocol ViewControllerViewModelProtocol {
    var showAlertEvent: Observable<AlertViewModel?> { get }
    var showActionSheetEvent: Observable<AlertViewModel?> { get }
    var showLoadingEvent: Observable<Bool> { get }
}
