//
//  CryptoCoinVM.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 19/08/23.
//

import Foundation

struct CryptoCoinVM {
    
    // MARK: - Properties
    
    let cryptoCoinData: GeckoCryptoCoin
    let currency: Currency
    
    private let dateFormatter: DateFormatter = {
        let formater = DateFormatter()
        formater.dateFormat = "YY, MMM d - HH:mm:ss"
        return formater
    }()
    
    private let currencyFormatter: NumberFormatter = {
        let formater = NumberFormatter()
        formater.numberStyle = .currencyISOCode
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
    
    var symbol: String { cryptoCoinData.symbol }
    
    var currentPrice: String { currencyFormatter.string(from: NSNumber(value: cryptoCoinData.currentPrice)) ?? "n/a" }
    
    var lastUpdated: String { dateFormatter.string(from: cryptoCoinData.lastUpdated) }
    
    var image: URL? { URL(string:  cryptoCoinData.image) }
    
}
