//
//  CriptoCoinRepresentable.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 19/08/23.
//

import Foundation

protocol CriptoCoinRepresentable {
    var name: String { get }
    var symbol: String { get }
    var currentPrice: Double { get }
    var lastUpdated: String { get }
    var image: String { get }
}
