//
//  ViewController.swift
//  PershinTestApp
//
//  Created by Sergey Pershin on 07.04.2021.
//

import UIKit


protocol ExampleViewModelProtocol: ViewControllerViewModelProtocol {
    func textNeedsChange()
    var text: Observable<String> { get }
    var event: ObservableEvent { get }
}


class ViewController: UIViewController {
    private var viewModel: ExampleViewModelProtocol! {
        didSet {
            self.loadViewModel()
        }
    }
    
    @IBOutlet private weak var testView: CustomNibView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .red
        
        self.testView.delegate = self
        
        //can be constructed in some other place
        self.viewModel = ViewControllerViewModel()
    }
    
    private func loadViewModel() {
        self.viewModel.text.bind {[weak self] (value) in
            guard let s = self else { return }
            s.testView.set(text: value)
        }
        
        self.viewModel.event.bind {[weak self] (_) in
            guard let s = self else { return }
            s.testView.set(text: "3 sec passed!")
        }
        
        self.viewModel.showAlertEvent.bind {[weak self] (alertVM) in
            guard let s = self, let alertVM = alertVM else { return }
            s.showAlert(alertVM)
        }
        
        self.viewModel.showActionSheetEvent.bind {[weak self] (alertVM) in
            guard let s = self, let alertVM = alertVM else { return }
            s.showActionSheet(alertVM)
        }

        self.testView.set(text: self.viewModel.text.value)
    }
}


extension ViewController: CustomNibViewDelegate {
    func didPressButton(on: CustomNibView) {
        self.viewModel.textNeedsChange()
    }
}

