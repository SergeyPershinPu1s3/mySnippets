//
//  ViewControllerViewModel.swift
//  PershinTestApp
//
//  Created by Sergey Pershin on 09.04.2021.
//

import Foundation


class ViewControllerViewModel: BaseViewModel, ViewControllerViewModelProtocol {
    func textNeedsChange() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.text.value = Date().description
            self.event.value = ()
        }
    }
    
    var text: Observable<String> = Observable("")
    var event: Observable<Void> = Observable(())
}

