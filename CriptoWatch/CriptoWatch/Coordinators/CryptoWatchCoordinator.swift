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
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
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
        let coinsListViewModel = CryptoCoinsListVM(networkService: NetworkManager())
        
        // Installing closure handlers
        coinsListViewModel.didSelectCryptoCoin = { [weak self] (cryptoCoinData, currency) in
            self?.cryptoDetail(cryptoCoinData, currency)
        }
        
        // Initializing Cripto Coins List View Controller
        let coinsListVC = CryptoCoinsListVC()
        // Injecting View Model
        coinsListVC.viewModel = coinsListViewModel
        
        // Push Coins List View Controller Onto Navigation Stack
        navigationController.pushViewController(coinsListVC, animated: true)
    }
    
    private func cryptoDetail(_ crypto: GeckoCryptoCoin, _ currency: Currency) {
        // Initalizing Crypto Coin List View Model
        let coinsListViewModel = CryptoCoinVM(cryptoCoinData: crypto, currency: currency)
        
        // Initialize Crytp Detail View Controller
        let cryptoCoinDetail = CryptoDetailVC()
        // Injecting View Model
        cryptoCoinDetail.viewModel = coinsListViewModel
        
        // Push Crypto Detail View Controller onto navigations tack
        navigationController.pushViewController(cryptoCoinDetail, animated: true)
    }
}
