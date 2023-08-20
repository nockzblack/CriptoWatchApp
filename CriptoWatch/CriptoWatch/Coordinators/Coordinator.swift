//
//  Coordinator.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 18/08/23.
//

import Foundation
import UIKit

class Coordinator: NSObject {
    
    // MARK: - Properties
    
    var didFinish: ((Coordinator) -> Void)?
    
    var childCoordinators: [Coordinator] = []
    
    // MARK: - Public API

    func start() {}

    func pushCoordinator(_ coordinator: Coordinator) {
        // Installing closure handler
        coordinator.didFinish = { [weak self] (coordinator) in
            self?.popCoordinator(coordinator)
        }

        // Starting coordinator
        coordinator.start()

        // Appending child coordinators
        childCoordinators.append(coordinator)
    }

    func popCoordinator(_ coordinator: Coordinator) {
        // Removing coordinator from child coordinators
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
    
}


extension Coordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {}
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {}
    
}

