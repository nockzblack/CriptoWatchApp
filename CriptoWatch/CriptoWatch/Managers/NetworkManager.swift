//
//  NetworkManager.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 24/08/23.
//

import Foundation

class NetworkManager: NetworkService {
    
    // MARK: - Network Service
    
    func fetchData(with url: URL, completionHandler: @escaping NetworkService.FetchDataCompletion) {
        URLSession.shared.dataTask(with: url, completionHandler: completionHandler).resume()
    }
    
}
