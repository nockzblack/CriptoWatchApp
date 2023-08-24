//
//  CryptoCoinVM.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 19/08/23.
//

import Foundation

struct CryptoCoinVM {
    
    // MARK: - Properties
    
    private let cryptoCoinData: GeckoCryptoCoin
    private let currency: Currency
    
    private let dateFormatter: DateFormatter = {
        let formater = DateFormatter()
        formater.dateFormat = "YY, MMM d - HH:mm:ss"
        return formater
    }()
    
    private let currencyFormatter: NumberFormatter = {
        let formater = NumberFormatter()
        formater.numberStyle = .currencyISOCode
        formater.minimumFractionDigits = 2
        formater.maximumFractionDigits = 6
        formater.locale = Locale(identifier: "en_US")
        return formater
    }()
    
    
    init(cryptoCoinData: GeckoCryptoCoin, currency: Currency) {
        self.cryptoCoinData = cryptoCoinData
        self.currency = currency
        currencyFormatter.currencyCode = currency.rawValue.uppercased()
    }
}

extension CryptoCoinVM: CryptoCoinRepresentable {
    
    var name: String { cryptoCoinData.name }
    
    var symbol: String { cryptoCoinData.symbol.uppercased() }
    
    var currentPrice: String { currencyFormatter.string(from: NSNumber(value: cryptoCoinData.currentPrice)) ?? "NaN" }
    
    var lastUpdated: String { dateFormatter.string(from: cryptoCoinData.lastUpdated) }
    
    var image: URL? { URL(string:  cryptoCoinData.image) }
    
}

extension CryptoCoinVM: CryptoDetailRepresentable {
    
    var totalVolume: String {
        currencyFormatter.string(from: NSNumber(value: cryptoCoinData.totalVolume)) ?? "NaN"
    }
    
    var hightest24H: String {
        currencyFormatter.string(from: NSNumber(value: cryptoCoinData.high24H)) ?? "NaN"
    }
    
    var lowest24H: String {
        currencyFormatter.string(from: NSNumber(value: cryptoCoinData.low24H)) ?? "NaN"
    }
    
    var priceChange24H: String {
        currencyFormatter.string(from: NSNumber(value: cryptoCoinData.priceChangePercentage24H)) ?? "NaN"
    }
    
    var marketCap: String {
        currencyFormatter.string(from: NSNumber(value: cryptoCoinData.marketCap)) ?? "NaN"
    }
    
    var priceChange24HIsNegative: Bool {
        return cryptoCoinData.priceChangePercentage24H.isLess(than: 0.0)
    }
    
}
