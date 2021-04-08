//
//  ViewController.swift
//  PershinTestApp
//
//  Created by Sergey Pershin on 07.04.2021.
//

import UIKit


protocol ViewControllerViewModelProtocol {
    func textNeedsChange()
    var text: Observable<String> { get }
    var event: Observable<Void> { get }
}


class ViewController: UIViewController {
    private var viewModel: ViewControllerViewModelProtocol!
    
    @IBOutlet private weak var testView: CustomNibView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .red
        
        self.testView.delegate = self
        
        //can be constructed in some other place
        self.viewModel = ViewControllerViewModel()
        
        self.viewModel.text.bind {[weak self] (value) in
            //self?.testView.set(text: value)
        }
        
        self.viewModel.event.bind {[weak self] (value) in
            guard let s = self else { return }
            s.testView.set(text: s.viewModel.text.value)
            //self?.testView.set(text: value)
        }
    }
}


extension ViewController: CustomNibViewDelegate {
    func didPressButton(on: CustomNibView) {
        self.viewModel.textNeedsChange()
    }
}

