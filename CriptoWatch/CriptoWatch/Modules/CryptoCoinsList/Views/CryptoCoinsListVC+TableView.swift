//
//  CryptoCoinsListVC+TableView.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 19/08/23.
//

import UIKit

// MARK: - Table View Data Source
extension CryptoCoinsListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfCryptos ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoCoinTableViewCell.reuseIdentifier, for: indexPath) as? CryptoCoinTableViewCell else { fatalError("Unexpected Index Path")
        }
        
        // Validating view model
        guard let viewModel = viewModel else { fatalError("No view model present") }
        
        // Configuring Cell
        if let cryptoVM = viewModel.viewModel(for: indexPath.row) {
            cell.configure(with: cryptoVM)
        }
       
        return cell
    }
    
}

// MARK: - Table View Delegate
extension CryptoCoinsListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Notifying view model
        viewModel?.selectCryptoCoin(at: indexPath.row)
    }
}
