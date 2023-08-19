//
//  CriptoCoinsListVC.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 18/08/23.
//

import UIKit

final class CriptoCoinsListVC: UIViewController {
    
    
    // MARK: - Properties
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.red
        tableView.register(CryptoCoinTableViewCell.self, forCellReuseIdentifier: CryptoCoinTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Table View
        setupTableView()
    }
    
    
    
    // MARK: Private API
    
    private func setupTableView() {
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
    
    
}
