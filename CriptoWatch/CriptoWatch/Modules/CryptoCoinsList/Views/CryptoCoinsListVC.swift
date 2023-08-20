//
//  CriptoCoinsListVC.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 18/08/23.
//

import UIKit

final class CryptoCoinsListVC: UIViewController {
    
    // MARK: - Inner Types
    
    private enum AlertType {
        case noComicDataAvailable
        case noResultsFromSearch
    }
    
    
    // MARK: - Properties
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CryptoCoinTableViewCell.self, forCellReuseIdentifier: CryptoCoinTableViewCell.reuseIdentifier)
        tableView.isHidden = true
        return tableView
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndecator = UIActivityIndicatorView()
        activityIndecator.translatesAutoresizingMaskIntoConstraints = false
        activityIndecator.hidesWhenStopped = true
        activityIndecator.style = .large
        activityIndecator.isHidden = false
        activityIndecator.startAnimating()
        return activityIndecator
    }()
    
    var viewModel: CryptoCoinsListVM? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            // Setting up view model
            setupViewModel(with: viewModel)
        }
    }
    
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuring View Controller
        title = "Crypto Coins"
        view.backgroundColor = .white
        
        
        // Table View
        setupTableView()
        // Activity Indicator
        setupActivityIndicator()
    }
    
}


// MARK: Private API
private extension CryptoCoinsListVC {
    
    func setupActivityIndicator() {
        self.view.addSubview(activityIndicatorView)
        // Layout
        NSLayoutConstraint.activate([
            // Center
            activityIndicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
    
    func setupTableView() {
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        // Layout
        NSLayoutConstraint.activate([
            // Vertical Layout
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            // Horizontal Layout
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    func setupViewModel(with viewModel: CryptoCoinsListVM) {
        viewModel.startFetchingData()
        // Configure view model
        viewModel.didFetchCryptoCoinData = { [weak self] (criptoCoinsData, error) in
            
            if let error = error {
                // Notify user according error type
                switch error {
                    case .noCryptoDataAvailable:
                        self?.presentAlert(of: .noComicDataAvailable)
                    case .noResultsFromQuery:
                        self?.presentAlert(of: .noResultsFromSearch)
                }
            } else if let _ = criptoCoinsData {
                DispatchQueue.main.async {
                    // Stop animation
                    self?.activityIndicatorView.stopAnimating()
                    
                    // Update collection view
                    self?.tableView.reloadData()
                    self?.tableView.isHidden = false
                }
            } else {
                // Notify User
                self?.presentAlert(of: .noComicDataAvailable)
            }
        }
    }
    
    func presentAlert(of alertType: AlertType) {
        // Helpers
        let title: String
        let message: String
        
        switch alertType {
            case .noComicDataAvailable:
                title = "Unable to get cryptos"
                message = "The application is unable to fetch coins. Please make sure to be connected over Wi-Fi or cellular."
            case .noResultsFromSearch:
                title = "There is no cryptos to show"
                message = "Maybe there is a typo on your search"
        }
        
        // Initializing Alert Controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Adding Cancel Action
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        
        DispatchQueue.main.async {
            // Presenting Alert Controller
            self.present(alertController, animated: true)
        }
    }
}
    


