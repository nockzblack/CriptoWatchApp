//
//  CriptoCoinsListVM.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 19/08/23.
//

import Foundation

import Foundation

enum source {
    case api
}

final class CriptoCoinsListVM {
    
    // MARK: - Inner Types
    
    enum CryptoDataError: Error {
        case noCryptoDataAvailable
        case noResultsFromQuery
    }
    
    
    // MARK: - Type Aliases
    
    typealias DidFetchCryptoCoinsDataCompletion = ([GeckoCriptoCoin]?, CryptoDataError?) -> Void
    
    
    // MARK: - Stored Properties
    
    var didFetchCryptoCoinData: DidFetchCryptoCoinsDataCompletion?
    
    var cryptoCoinsData: [GeckoCriptoCoin]?
    
    // MARK: - Computed Properties
    
    var numberOfCryptoCoins: Int {
        return cryptoCoinsData?.count ?? 0
    }
    
    
    // MARK: - Initializers
    
    init() {
        cryptoCoinsData = []
        // Fetch Crypto Coin Data
        fetchCriptoCoinData(with: GeckoAPI.getURL(for: .usd))
    }
    
    
}


// MARK: - Public API

extension CriptoCoinsListVM {
    

}


// MARK: - Private API

private extension CriptoCoinsListVM {
    func fetchCriptoCoinData(with url: URL) {
        // Creating data taks
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            // Informing Http response code
            if let response = response as? HTTPURLResponse {
                print("Status Code: \(response.statusCode)")
            }
            
            if let error = error {
                print("Requested did fail \(error)")
                
                // Invoking completation handler with failure
                self?.didFetchCryptoCoinData?(nil, .noCryptoDataAvailable)
                
            } else if let data = data {
                
                // Initializing JSON Decoder
                let decoder = JSONDecoder()
                
                do {
                    // Decoding JSON data
                    let geckoResponse = try decoder.decode([GeckoCriptoCoin].self, from: data)
                    
                    // Check if there is results
                    if geckoResponse.isEmpty {
                        // Invoking completation handler to inform user
                        self?.didFetchCryptoCoinData?(nil, .noResultsFromQuery)
                    }
                    
                    // Seting comics data
                    self?.cryptoCoinsData?.append(contentsOf: geckoResponse)
                    
                    // Invoking completation handler
                    self?.didFetchCryptoCoinData?(geckoResponse, nil)
                    
                } catch {
                    print("Unable to decode JSON \(error)")
                    
                    // Invoking completation handler with failure
                    self?.didFetchCryptoCoinData?(nil, .noCryptoDataAvailable)
                }
                
            } else {
                // Invoking completation handler with failure
                self?.didFetchCryptoCoinData?(nil, .noCryptoDataAvailable)
                
            }
        }.resume()
    }
}
