//
//  CryptoCoinRepresentable.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 19/08/23.
//

import Foundation

protocol CryptoCoinRepresentable {
    var name: String { get }
    var symbol: String { get }
    var currentPrice: String { get }
    var lastUpdated: String { get }
    var image: URL? { get }
}
