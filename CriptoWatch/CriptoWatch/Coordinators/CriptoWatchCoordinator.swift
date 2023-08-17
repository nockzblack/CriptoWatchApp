//
//  CriptoWatchCoordinator.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 18/08/23.
//

import UIKit

class CriptoWatchCoordinator: Coordinator {
    
    // MARK: - Properties
    
    private let navigationController = UINavigationController()
    
    
    // MARK: - Computed Properties
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    
    // MARK: - Overrides
    
    override func start() {
        navigationController.delegate = self
        
        // Applying style to navigation bar
        navigationController.navigationBar.tintColor = .systemBlue
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        
    }
    
    override func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        childCoordinators.forEach { (childCoordinator) in
            childCoordinator.navigationController(navigationController, willShow: viewController, animated: animated)
        }
    }
    
    override func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        childCoordinators.forEach { (childCoordinator) in
            childCoordinator.navigationController(navigationController, didShow: viewController, animated: animated)
        }
    }
}
