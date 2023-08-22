//
//  CryptoDetailRepresentable.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 21/08/23.
//

import Foundation

protocol CryptoDetailRepresentable {
    var name: String { get }
    var symbol: String { get }
    var currentPrice: String { get }
    var lastUpdated: String { get }
    var image: URL? { get }
    var totalVolume: String { get }
    var hightest24H: String { get }
    var lowest24H: String { get }
    var priceChange24H: String { get }
    var marketCap: String { get }
    var priceChange24HIsNegative: Bool { get }
}
