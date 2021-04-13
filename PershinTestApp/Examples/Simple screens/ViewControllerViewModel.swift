//
//  ViewControllerViewModel.swift
//  PershinTestApp
//
//  Created by Sergey Pershin on 09.04.2021.
//

import Foundation


class ViewControllerViewModel: ViewControllerViewModelProtocol, ExampleViewModelProtocol {
    func textNeedsChange() {
        self.text.value = Date().description
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.event.fire()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let testAlert = AlertViewModel(description: "Hello world!")
            self.showActionSheetEvent.value = testAlert
        }
    }
    
    var text: Observable<String> = Observable("")
    var event: ObservableEvent = ObservableEvent()
    
    var showAlertEvent: Observable<AlertViewModel?> = Observable(nil)
    var showActionSheetEvent: Observable<AlertViewModel?> = Observable(nil)
    var showLoadingEvent: Observable<Bool> = Observable(false)
}

