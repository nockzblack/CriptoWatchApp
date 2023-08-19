//
//  CriptoCoinsListVC+TableView.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 19/08/23.
//

import UIKit

// MARK: - Table View Data Source
extension CriptoCoinsListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoCoinTableViewCell.reuseIdentifier, for: indexPath) as? CryptoCoinTableViewCell else { fatalError("Unexpected Index Path")
        }
        
        // TODO: Configure Cell
        
        return cell
    }
    
    
}

// MARK: - Table View Delegate
extension CriptoCoinsListVC: UITableViewDelegate {
    
}
