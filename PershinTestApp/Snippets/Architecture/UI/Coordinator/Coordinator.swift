//
//  Coordinator.swift
//  PershinTestApp
//
//  Created by Sergey Pershin on 08.04.2021.
//

import UIKit

protocol CoordinatorProtocol: class {
    func start()
    func stop()
    func moveToRoot(animated: Bool)
}


protocol HierarchyCoordinatorProtocol: CoordinatorProtocol {
    func addDependency(_ coordinator: CoordinatorProtocol)
    func removeDependency(_ coordinator: CoordinatorProtocol)
}


class HierarchyCoordinator {
    var viewController: UIViewController!
    var router: RouterProtocol!
    var parent: HierarchyCoordinatorProtocol?
    
    init(parent: HierarchyCoordinatorProtocol? = nil) {
        self.parent = parent
    }
    
    var childCoordinators = [CoordinatorProtocol]()
}

extension HierarchyCoordinator: HierarchyCoordinatorProtocol {
    func addDependency(_ coordinator: CoordinatorProtocol) {
        for element in self.childCoordinators {
            if element === coordinator { return }
        }
        self.childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: CoordinatorProtocol) {
        guard self.childCoordinators.isEmpty == false else { return }
        
        for (index, element) in self.childCoordinators.enumerated() {
            if element === coordinator {
                self.childCoordinators.remove(at: index)
                break
            }
        }
    }

    func start() {
        self.parent?.addDependency(self)
    }
    
    func stop(){
        for child in self.childCoordinators {
            guard let child = child as? HierarchyCoordinator else {continue}
            child.stop()
            self.removeDependency(child)
        }
        self.parent?.removeDependency(self)
    }
    
    func moveToRoot(animated: Bool) {
        self.router.popToRootModule(animated: true)
    }
}
