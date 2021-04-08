//
//  Router.swift
//  PershinTestApp
//
//  Created by Sergey Pershin on 08.04.2021.
//

import UIKit

protocol Presentable {
    func toPresent() -> UIViewController?
}

protocol RouterProtocol: Presentable {
    func present(_ module: Presentable?, animated: Bool)
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    
    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool, completion: (() -> Void)?)
    func popModule(transition: UIViewControllerAnimatedTransitioning?, animated: Bool)
    
    func setRootModule(_ module: Presentable?, hideBar: Bool, animated: Bool, completion: (() -> Void)?)
    
    func popToRootModule(animated: Bool)
    func popToModule(module: Presentable?, animated: Bool)
}

final class Router: NSObject {
    private weak var rootController: UINavigationController?
    private var completions = [UIViewController : () -> Void]()
    private var transition: UIViewControllerAnimatedTransitioning?
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
        super.init()
        self.rootController?.delegate = self
    }
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = self.completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
    
    
    private func pop(count: Int, animated: Bool) {
        guard let nvc = self.rootController else { return }
        
        let index = nvc.viewControllers.count - count - 1
        if index < 0{
            return
        }
        
        let controllersCount = nvc.viewControllers.count
        
        let vc = nvc.viewControllers[index]
        let subArray = nvc.viewControllers[index + 1...controllersCount - 1].reversed()
        for vc in subArray {
            self.runCompletion(for: vc)
        }
        nvc.popToViewController(vc, animated: true)
    }
}

extension Router: RouterProtocol {
    func toPresent() -> UIViewController? {
        return self.rootController
    }
    
    func presentError(_ alertModel: AlertViewModel) {
        self.rootController?.showAlert(alertModel)
    }

    func present(_ module: Presentable?, animated: Bool = true) {
        guard let controller = module?.toPresent() else { return }
        
        let present = {
            self.rootController?.present(controller, animated: animated, completion: nil)
            self.rootController?.navigationBar.barStyle = controller.preferredStatusBarStyle.barStyle
            
            if let coordinator = module as? CoordinatorProtocol {
                coordinator.start()
            }
        }
        
        if self.rootController?.presentedViewController != nil {
            self.dismissModule(animated: false) {
                present()
            }
        } else {
            present()
        }
    }

    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning? = nil, animated: Bool = true, completion: (() -> Void)? = nil) {
        self.transition = transition
        guard let controller = module?.toPresent(),
            (controller is UINavigationController == false)
            else { assertionFailure("Deprecated push UINavigationController."); return }
        
        if let completion = completion {
            self.completions[controller] = completion
        }
        self.rootController?.pushViewController(controller, animated: animated)
        self.rootController?.navigationBar.barStyle = controller.preferredStatusBarStyle.barStyle
        
        if let coordinator = module as? HierarchyCoordinator {
            coordinator.viewController = controller
            coordinator.start()
        }
    }

    func popModule(transition: UIViewControllerAnimatedTransitioning? = nil, animated: Bool = true) {
        self.transition = transition
        if let controller = rootController?.popViewController(animated: animated) {
            self.runCompletion(for: controller)
        }
    }

    func dismissModule(animated: Bool = true, completion: (() -> Void)? = nil) {
        self.rootController?.dismiss(animated: animated, completion: completion)
    }

    func setRootModule(_ module: Presentable?, hideBar: Bool = false, animated: Bool = false, completion: (() -> Void)? = nil) {
        guard let controller = module?.toPresent() else { return }
        if let controllers = self.rootController?.viewControllers {
            controllers.forEach { (controller) in
                self.runCompletion(for: controller)
            }
        }
        
        if let completion = completion {
            self.completions[controller] = completion
        }
        
        self.rootController?.setViewControllers([controller], animated: animated)
        self.rootController?.isNavigationBarHidden = hideBar
        
        if let coordinator = module as? CoordinatorProtocol {
            coordinator.start()
        }
    }
    
    func popToModule(module: Presentable?, animated: Bool) {
        var destination : UIViewController?
        if let vc = module as? UIViewController {
            destination = vc
        }
        if let coordinator = module as? HierarchyCoordinator {
            destination = coordinator.viewController
        }
        
        guard let popTo = destination else { return }
        let controllers = self.rootController?.popToViewController(popTo, animated: animated)
        if let controllers = controllers {
            for controller in controllers {
                self.runCompletion(for: controller)
            }
        }
    }
    
    func popToRootModule(animated: Bool) {
        if let controllers = self.rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                self.runCompletion(for: controller)
            }
        }
    }
}

extension Router: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .pop {
            if let completion = self.completions[fromVC]{
                completion()
                self.completions.removeValue(forKey: fromVC)
            }
        }
        return self.transition
    }
}
