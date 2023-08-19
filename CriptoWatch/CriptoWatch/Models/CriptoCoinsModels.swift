//
//  CriptoCoinsModels.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 19/08/23.
//

import Foundation

struct GeckoCriptoCoin: Codable {
    
    // MARK: - Properties
    let id: String
    let symbol: String
    let name: String
    let image: String
    let current_price: Double
    let last_updated: String
    let total_volume: Double
    let high_24h: Double
    let low_24h: Double
    let price_change_percentage_24h: Double
    let market_cap: Double
}
