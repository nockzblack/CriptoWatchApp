//
//  GeckoAPI.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 19/08/23.
//

import Foundation

enum GeckoAPI {

    // MARK: - Store Static Properties API
    
    private static var basePath = "https://api.coingecko.com/api/v3/"
    private static var coinsMarketsQuery = basePath + "coins/markets"
    
    // MARK: - Computed Static Properties API
    
    static func getURL(for currency: Currency) -> URL {
        guard let url = URL(string: "\(coinsMarketsQuery)?vs_currency=\(currency.rawValue)&per_page=20") else {
            fatalError("Not an URL")
        }
        return url
    }
}
