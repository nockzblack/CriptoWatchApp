//
//  GeckoCryptoCoin.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 19/08/23.
//

import Foundation

struct GeckoCryptoCoin: Codable {
    
    // MARK: - Properties
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Double
    let lastUpdated: String
    let totalVolume: Double
    let high24H: Double
    let low24H: Double
    let priceChangePercentage24H: Double
    let marketCap: Double
}
