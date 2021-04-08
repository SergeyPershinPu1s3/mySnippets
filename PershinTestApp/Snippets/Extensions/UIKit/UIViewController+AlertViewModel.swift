//
//  UIViewController+AlertViewModel.swift
//  PershinTestApp
//
//  Created by Sergey Pershin on 08.04.2021.
//

import UIKit

extension UIViewController {
    func showActionSheet(_ actionSheetModel: AlertViewModel) {
        guard self.presentedViewController == nil else {
            print("\(#function): \(self) already has a presented view controller.")
            return
        }
        
        let actionSheetVC = UIAlertController(title: actionSheetModel.title,
                                              message: actionSheetModel.description,
                                              preferredStyle: .actionSheet)
        for action in actionSheetModel.actions {
            actionSheetVC.addAction(action)
        }

        self.present(actionSheetVC, animated: true, completion: nil)
    }
    
    func showAlert(_ alertModel: AlertViewModel) {
        guard self.presentedViewController == nil else {
            print("\(#function): \(self) already has a presented view controller.")
            return
        }
        
        let alertVC = UIAlertController(title: alertModel.title,
                                        message: alertModel.description,
                                        preferredStyle: .alert)
        for textFields in alertModel.textFields {
            alertVC.addTextField(configurationHandler: textFields)
        }
        for action in alertModel.actions {
            alertVC.addAction(action)
        }
        self.present(alertVC, animated: true, completion: nil)
    }
}
