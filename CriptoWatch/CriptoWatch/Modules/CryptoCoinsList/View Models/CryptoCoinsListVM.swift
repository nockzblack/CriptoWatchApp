//
//  CryptoCoinsListVM.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 19/08/23.
//

import Foundation

import Foundation

enum source {
    case api
}

final class CryptoCoinsListVM {
    
    // MARK: - Inner Types
    
    enum CryptoDataError: Error {
        case noCryptoDataAvailable
        case noResultsFromQuery
    }
    
    // MARK: - Type Aliases
    
    typealias DidFetchCryptoCoinsDataCompletion = ([GeckoCryptoCoin]?, CryptoDataError?) -> Void
    
    
    // MARK: - Stored Properties
    
    var didFetchCryptoCoinData: DidFetchCryptoCoinsDataCompletion?
    
    var cryptoCoinsData: [GeckoCryptoCoin]
    
    // MARK: - Computed Properties
    
    var numberOfCryptoCoins: Int { cryptoCoinsData.count }
    
    // MARK: - Initializers
    
    init() {
        cryptoCoinsData = []
    }
    
}


// MARK: - Public API

extension CryptoCoinsListVM {
    
    func startFetchingData() {
        // Fetch Crypto Coin Data
        fetchCryptoCoinData(with: GeckoAPI.getURL(for: .usd))
    }

}


// MARK: - Private API

private extension CryptoCoinsListVM {
    func fetchCryptoCoinData(with url: URL) {
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
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    // Decoding JSON data
                    let geckoResponse = try decoder.decode([GeckoCryptoCoin].self, from: data)
                    
                    // Check if there is results
                    if geckoResponse.isEmpty {
                        // Invoking completation handler to inform user
                        self?.didFetchCryptoCoinData?(nil, .noResultsFromQuery)
                    }
                    
                    // Seting comics data
                    self?.cryptoCoinsData.append(contentsOf: geckoResponse)
                    
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
