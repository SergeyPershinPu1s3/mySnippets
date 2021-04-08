//
//  NibView.swift
//  PershinTestApp
//
//  Created by Sergey Pershin on 08.04.2021.
//

import UIKit



/*
 1. Name XIB and view class the same.
 2. Specify this class as a FILE OWNER of XIB, not as class name of XIB's view.
 3. To use XIB inside of other XIB, add it as UIView and change class name to your view class.
 4. Setup your view in .awakeFromNib().
 */


protocol NibViewProtocol {
    func loadContent()
}

extension NibViewProtocol where Self: UIView {
    func loadContent() {
        let bundle = Bundle(for: type(of: self))
        let className = String(describing: type(of: self))
        guard let view = bundle.loadNibNamed(className, owner: self, options: nil)?.first as? UIView else {
            fatalError("\(className) XIB was not found in bundle \(bundle)")
        }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        
        self.backgroundColor = .clear
    }
}

//most custom views are UIView with custom contents
//in 90% of cases this class can be inherited and used as is

class NibView: UIView, NibViewProtocol {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadContent()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        self.loadContent()
    }
}
