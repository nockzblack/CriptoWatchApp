//
//  CriptoCoinsListVC+TableView.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 19/08/23.
//

import UIKit

// MARK: - Table View Data Source
extension CryptoCoinsListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfCryptoCoins ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoCoinTableViewCell.reuseIdentifier, for: indexPath) as? CryptoCoinTableViewCell else { fatalError("Unexpected Index Path")
        }
        
        // Validating view model
        guard let viewModel = viewModel else { fatalError("No view model present") }
        
        // Configuring Cell
        cell.configure(with: viewModel.cryptoCoinsData?[indexPath.row])
        return cell
    }
    
    
}

// MARK: - Table View Delegate
extension CryptoCoinsListVC: UITableViewDelegate {
    
}
