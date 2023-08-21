//
//  CryptoWatchCoordinator.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 18/08/23.
//

import UIKit

class CryptoWatchCoordinator: Coordinator {
    
    // MARK: - Properties
    
    private let navigationController = UINavigationController()
    
    
    // MARK: - Computed Properties
    
    var rootViewController: UIViewController { return navigationController }
    
    
    // MARK: - Overrides
    
    override func start() {
        navigationController.delegate = self
        
        // Applying style to navigation bar
        navigationController.navigationBar.tintColor = .systemBlue
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemTeal]
        
        // Show Cripto List
        showCryptoCoinsList()
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
    
    
    // MARK: - Private API
    
    private func showCryptoCoinsList() {
        // Initalizing Crypto Coins List View Model
        let coinsListViewModel = CryptoCoinsListVM()
        
        // Installing closure handlers
        coinsListViewModel.didSelectCryptoCoin = { [weak self] (cryptoCoinData) in
            self?.cryptoDetail(cryptoCoinData)
        }
        
        // Initializing Cripto Coins List View Controller
        let coinsListVC = CryptoCoinsListVC()
        coinsListVC.viewModel = coinsListViewModel
        
        // Push Coins List View Controller Onto Navigation Stack
        navigationController.pushViewController(coinsListVC, animated: true)
    }
    
    private func cryptoDetail(_ crypto: GeckoCryptoCoin) {
        // Initialize Crytp Detail View Controller
        let cryptoCoinDetail = CryptoDetailVC()
        
        // Push Crypto Detail View Controller onto navigations tack
        navigationController.pushViewController(cryptoCoinDetail, animated: true)
    }
}
