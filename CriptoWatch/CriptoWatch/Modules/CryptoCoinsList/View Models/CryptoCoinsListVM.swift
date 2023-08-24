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
    
    enum SortOptions {
        case name
        case marketCap
        case price
    }
    
    // MARK: - Type Aliases
    
    typealias DidFetchCryptoCoinsDataCompletion = ([GeckoCryptoCoin]?, CryptoDataError?) -> Void
    
    
    // MARK: - Stored Properties
    
    var didFetchCryptoCoinData: DidFetchCryptoCoinsDataCompletion?
    
    var didSelectCryptoCoin: ((GeckoCryptoCoin, Currency) -> Void)?
    
    var currency: Currency
    
    private let networkService: NetworkService
    
    private var cryptoCoinsData: [GeckoCryptoCoin]
    
    private var filter: String?
    
    
    // MARK: - Computed Properties
    
    var cryptos: [GeckoCryptoCoin] {
        if let filter = self.filter {
            return cryptoCoinsData.filter { crypto in
                return (crypto.name.lowercased().contains(filter)) || (crypto.symbol.lowercased().contains(filter))
            }
        }
        return cryptoCoinsData
    }
    
    var numberOfCryptos: Int {
        cryptos.count
    }
        
    
    // MARK: - Initializers
    
    init(networkService: NetworkService) {
        self.networkService = networkService
        cryptoCoinsData = []
        currency = .usd
    }
    
}


// MARK: - Public API

extension CryptoCoinsListVM {
    
    func startFetchingData() {
        // Fetch Crypto Coin Data
        fetchCryptoCoinData(with: GeckoAPI.getURL(for: currency))
    }
    
    func viewModel(for index: Int) -> CryptoCoinVM? {
        
        guard let crypto = cryptos[safe: index] else {
            return nil
        }
        
        // Making a Crypto Coin View Model
        return CryptoCoinVM(cryptoCoinData: crypto, currency: currency)
    }
    
    func sortCryptoCoins(by sort: SortOptions) {
        switch sort {
            case .name:
                cryptoCoinsData.sort { $0.name < $1.name }
            case .marketCap:
                cryptoCoinsData.sort { $0.marketCap > $1.marketCap }
            case .price:
                cryptoCoinsData.sort { $0.currentPrice > $1.currentPrice }
        }
    }
    
    func selectCryptoCoin(at index: Int) {
        didSelectCryptoCoin?(cryptoCoinsData[index], currency)
    }
    
    func filterCrypto(by title: String) {
        filter = title.lowercased()
        didFetchCryptoCoinData?([], nil)
    }
    
    func removeFilter() {
        filter = nil
        didFetchCryptoCoinData?([], nil)
    }

}


// MARK: - Private API

private extension CryptoCoinsListVM {
    func fetchCryptoCoinData(with url: URL) {
        // Creating data taks
        self.networkService.fetchData(with: url) { [weak self] (data, response, error) in
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
                let dateFormatted = DateFormatter()
                dateFormatted.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                decoder.dateDecodingStrategy = .formatted(dateFormatted)
        
                do {
                    // Decoding JSON data
                    let geckoResponse = try decoder.decode([GeckoCryptoCoin].self, from: data)
                    
                    // Check if there is results
                    if geckoResponse.isEmpty {
                        // Invoking completation handler to inform user
                        self?.didFetchCryptoCoinData?(nil, .noResultsFromQuery)
                    }
                    
                    // Seting comics data
                    self?.cryptoCoinsData.removeAll()
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
        }
    }
}
