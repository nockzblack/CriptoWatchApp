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
    
    
    // MARK: - UI Properties
    
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
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14, weight: .thin)
        ]
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Crypto Data ...", attributes: attributes)
        return refreshControl
    }()
    
    // MARK: - Object Properties
    
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
        title = "Coins"
        view.backgroundColor = .white
        
        // Table View
        setupTableView()
        // Activity Indicator
        setupActivityIndicator()
        // Currency Bar Item
        let currencyItem = configCurrencyItem()
        let sortItem = configSortItem()
        navigationItem.rightBarButtonItems = [currencyItem, sortItem]
    }
    
}


// MARK: Private API
private extension CryptoCoinsListVC {
    
    @objc private func fetchNewData(_ sender: Any) {
        viewModel?.startFetchingData()
    }
    
    func configCurrencyItem() -> UIBarButtonItem {
        let dollarImages = UIImage(systemName: "dollarsign.arrow.circlepath")
        let barItem = UIBarButtonItem(image: dollarImages, style: .plain, target: self, action: nil)
        barItem.primaryAction = nil
        
        // Create Three Action Items
        let USDOption = UIAction(title: "USD") { _ in
            self.viewModel?.currency = .usd
            self.viewModel?.startFetchingData()
        }
        
        let EUROption = UIAction(title: "EUR") { _ in
            self.viewModel?.currency = .eur
            self.viewModel?.startFetchingData()
        }
        
        let MXNOption = UIAction(title: "MXN") { _ in
            self.viewModel?.currency = .mxn
            self.viewModel?.startFetchingData()
        }
        
        // Create Menu with Action Items
        let menu = UIMenu(title: "Currency", children: [USDOption, EUROption, MXNOption])
        
        // Set Menu to Bar Items
        barItem.menu = menu
        
        return barItem
    }
    
    func configSortItem() -> UIBarButtonItem  {
        let arrowosImages = UIImage(systemName: "arrow.up.arrow.down")
        let barItem = UIBarButtonItem(image: arrowosImages, style: .plain, target: self, action:nil)
        barItem.primaryAction = nil
        
        // Create Sort mdoes Action
        let nameOption = UIAction(title: "Name", image: UIImage(systemName: "character.book.closed.fill")) { _ in
            self.viewModel?.sortCryptoCoins(by: .name)
            self.tableView.reloadData()
        }
        
        let priceOption = UIAction(title: "Price", image: UIImage(systemName: "dollarsign")) { _ in
            self.viewModel?.sortCryptoCoins(by: .price)
            self.tableView.reloadData()
        }
        
        let marketCapOption = UIAction(title: "Market Cap", image: UIImage(systemName: "chart.pie.fill")) { _ in
            self.viewModel?.sortCryptoCoins(by: .marketCap)
            self.tableView.reloadData()
        }
        
        // Return a UIMenu with the action items
        let menu = UIMenu(title: "Sort by", children: [nameOption, priceOption, marketCapOption])
        // Set Menu to Bar Items
        barItem.menu = menu
        
        return barItem
    }
    
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
        tableView.rowHeight = 80
        tableView.refreshControl = refreshControl
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(fetchNewData(_:)), for: .valueChanged)
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
                    self?.refreshControl.endRefreshing()
                    self?.tableView.isHidden = false
                }
            } else {
                // Notify User
                self?.presentAlert(of: .noComicDataAvailable)
            }
        }
    }
    
    private func presentAlert(of alertType: AlertType) {
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
    


