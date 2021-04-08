//
//  UIStatusBarStyle+Extension.swift
//  PershinTestApp
//
//  Created by Sergey Pershin on 09.04.2021.
//

import UIKit

extension UIStatusBarStyle {
    var barStyle: UIBarStyle {
        if self == .default {
            return .black
        } else if self == .lightContent {
            return .default
        } else {
            return .default
        }
    }
}
