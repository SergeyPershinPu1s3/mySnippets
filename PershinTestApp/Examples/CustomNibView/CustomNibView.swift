//
//  CustomNibView.swift
//  PershinTestApp
//
//  Created by Sergey Pershin on 08.04.2021.
//

import UIKit

protocol CustomNibViewDelegate: class {
    func didPressButton(on: CustomNibView)
}

class CustomNibView: NibView {
    @IBOutlet private weak var label: UILabel!

    weak var delegate: CustomNibViewDelegate?
    
    func set(text: String) {
        self.label.text = text
    }
    
    override func awakeFromNib() {
        self.label.text = "Test"
        self.label.textColor = .blue
    }
    
    @IBAction private func onButton() {
        self.delegate?.didPressButton(on: self)
    }
}
