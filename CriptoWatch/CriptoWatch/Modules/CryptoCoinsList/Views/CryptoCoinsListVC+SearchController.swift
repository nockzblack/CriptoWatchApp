//
//  CryptoCoinsListVC+SearchController.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 22/08/23.
//

import UIKit

extension CryptoCoinsListVC: UISearchResultsUpdating, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.tableView.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let title = searchBar.text else {
            return
        }
        activityIndicatorView.startAnimating()
        viewModel?.filterCrypto(by: title)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.removeFilter()
        self.tableView.isHidden = false
    }
    
}

extension CryptoCoinsListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.searchTextField.textColor = UIColor.systemGray
    }
}
