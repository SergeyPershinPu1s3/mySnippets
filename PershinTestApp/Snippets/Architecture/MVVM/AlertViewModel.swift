//
//  AlertViewModel.swift
//  PershinTestApp
//
//  Created by Sergey Pershin on 08.04.2021.
//

import UIKit

class AlertViewModel {
    var title: String?
    var description: String?
    var actions = [UIAlertAction]()
    var textFields = [((UITextField) -> Void)]()
    
    init(description: String?){
        self.description = description
        let okAction     = UIAlertAction(title: "Ok", style: .default, handler: nil)
        self.actions     = [okAction]
    }
    
    init(title: String?, description: String?, actions: [UIAlertAction], textFields: [((UITextField) -> Void)]? = nil){
        self.title = title
        self.description = description
        self.actions = actions
        if let fields = textFields {
            self.textFields = fields
        }
    }
    
    func addAction(_ action : UIAlertAction){
        self.actions.append(action)
    }
}

extension AlertViewModel {
    class func errorModel(_ error: Error) -> AlertViewModel {
        let title = "Error"
        return self.errorModel(title: title, error: error)
    }
    
    class func errorModel(title: String, error: Error) -> AlertViewModel {
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        return AlertViewModel(title: title, description: error.localizedDescription, actions: [okAction])
    }
}
