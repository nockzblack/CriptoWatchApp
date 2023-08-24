//
//  CryptoCoinVMTests.swift
//  CriptoWatchUnitTests
//
//  Created by Fernando Benavides on 23/08/23.
//

import XCTest
@testable import CriptoWatch

final class CryptoCoinVMTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: CryptoCoinVM!
    var coinData: GeckoCryptoCoin!
    var coinDataWithErorr: GeckoCryptoCoin! = GeckoCryptoCoin(id: "btc", symbol: "btc", name: "Bitcoin", image: "", currentPrice: .nan, lastUpdated: Date.distantFuture, totalVolume: .nan, high24H: .nan, low24H: .nan, priceChangePercentage24H: .nan, marketCap: .nan)
    
    
    // MARK: - Set Up & Tear Down

    override func setUpWithError() throws {
        // Load Stub
        let data = loadStub(name: "coinGecko", extension: "json")
        
        // Create JSON Decoder
        let decoder = JSONDecoder()
        
        // Configure JSON Decoder
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatted = DateFormatter()
        dateFormatted.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        decoder.dateDecodingStrategy = .formatted(dateFormatted)
        
        // Decode JSON
        let geckoResponse = try decoder.decode([GeckoCryptoCoin].self, from: data)
        coinData = geckoResponse[0]
        
        // Initialize View Model
        viewModel = CryptoCoinVM(cryptoCoinData: coinData, currency: .usd)
    }

    override func tearDownWithError() throws {
        
    }
    
    // MARK: - Tests for Date
    
    func testName() {
        XCTAssertEqual(viewModel.name, "Bitcoin")
    }
    
    // MARK: - Tests for Symbol
    
    func testSymbol() {
        XCTAssertEqual(viewModel.symbol, "BTC")
    }
    
    // MARK: - Tests for Current Price
    
    func testCurrentPrice_USD() {
        let viewModelUSD = CryptoCoinVM(cryptoCoinData: coinData, currency: .usd)
        XCTAssertEqual(viewModelUSD.currentPrice, "USD 26,290.00")
    }
    
    func testCurrentPrice_MXN() {
        let viewModelUSD = CryptoCoinVM(cryptoCoinData: coinData, currency: .mxn)
        XCTAssertEqual(viewModelUSD.currentPrice, "MXN 26,290.00")
    }
    
    func testCurrentPrice_EUR() {
        let viewModelUSD = CryptoCoinVM(cryptoCoinData: coinData, currency: .eur)
        XCTAssertEqual(viewModelUSD.currentPrice, "EUR 26,290.00")
    }
    
    func testCurrentPrice_NaN() {
        let viewModel = CryptoCoinVM(cryptoCoinData: coinDataWithErorr, currency: .eur)
        XCTAssertEqual(viewModel.currentPrice, "NaN")
    }
    
    // MARK: - Tests for Last Updated
    
    func testLastUpdated() {
        XCTAssertEqual(viewModel.lastUpdated, "23, Aug 18 - 13:46:38")
    }
    
    // MARK: - Tests for Image URL
    
    func testImageURL() {
        let urlReference = URL(string: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579")!
        
        XCTAssertNotNil(viewModel.image)
        XCTAssertEqual(viewModel.image, urlReference)
    }
    
    
    // MARK: - Tests for Total Volume
    
    func testTotalVolume_USD() {
        XCTAssertEqual(viewModel.totalVolume, "USD 34,881,033,102.00")
    }
    
    func testTotalVolume_MXN() {
        let viewModelUSD = CryptoCoinVM(cryptoCoinData: coinData, currency: .mxn)
        XCTAssertEqual(viewModelUSD.totalVolume, "MXN 34,881,033,102.00")
    }
    
    func testTotalVolume_EUR() {
        let viewModelUSD = CryptoCoinVM(cryptoCoinData: coinData, currency: .eur)
        XCTAssertEqual(viewModelUSD.totalVolume, "EUR 34,881,033,102.00")
    }
    
    func testTotalVolume_NaN() {
        let viewModel = CryptoCoinVM(cryptoCoinData: coinDataWithErorr, currency: .eur)
        XCTAssertEqual(viewModel.totalVolume, "NaN")
    }
    
    // MARK: - Tests for Highest 24H
    
    func testHighest24H_USD() {
        XCTAssertEqual(viewModel.hightest24H, "USD 28,411.00")
    }
    
    func testHighest24H_MXN() {
        let viewModelUSD = CryptoCoinVM(cryptoCoinData: coinData, currency: .mxn)
        XCTAssertEqual(viewModelUSD.hightest24H, "MXN 28,411.00")
    }
    
    func testHighest24H_EUR() {
        let viewModelUSD = CryptoCoinVM(cryptoCoinData: coinData, currency: .eur)
        XCTAssertEqual(viewModelUSD.hightest24H, "EUR 28,411.00")
    }
    
    func testHighest24H_NaN() {
        let viewModel = CryptoCoinVM(cryptoCoinData: coinDataWithErorr, currency: .eur)
        XCTAssertEqual(viewModel.hightest24H, "NaN")
    }
    
    // MARK: - Tests for Lowest 24H
    
    func testLowest24H_USD() {
        XCTAssertEqual(viewModel.lowest24H, "USD 25,649.00")
    }
    
    func testLowest24H_MXN() {
        let viewModelUSD = CryptoCoinVM(cryptoCoinData: coinData, currency: .mxn)
        XCTAssertEqual(viewModelUSD.lowest24H, "MXN 25,649.00")
    }
    
    func testLowest24H_EUR() {
        let viewModelUSD = CryptoCoinVM(cryptoCoinData: coinData, currency: .eur)
        XCTAssertEqual(viewModelUSD.lowest24H, "EUR 25,649.00")
    }
    
    func testLowest24H_NaN() {
        let viewModel = CryptoCoinVM(cryptoCoinData: coinDataWithErorr, currency: .eur)
        XCTAssertEqual(viewModel.lowest24H, "NaN")
    }
    
    // MARK: - Tests for Price Change 24H
    
    func testPriceChange24H_USD() {
        XCTAssertEqual(viewModel.priceChange24H, "-USD 7.42009")
    }
    
    func testPriceChange24H_MXN() {
        let viewModelUSD = CryptoCoinVM(cryptoCoinData: coinData, currency: .mxn)
        XCTAssertEqual(viewModelUSD.priceChange24H, "-MXN 7.42009")
    }
    
    func testPriceChange24H_EUR() {
        let viewModelUSD = CryptoCoinVM(cryptoCoinData: coinData, currency: .eur)
        XCTAssertEqual(viewModelUSD.priceChange24H, "-EUR 7.42009")
    }
    
    func testPriceChange24H_NaN() {
        let viewModel = CryptoCoinVM(cryptoCoinData: coinDataWithErorr, currency: .eur)
        XCTAssertEqual(viewModel.priceChange24H, "NaN")
    }
    
    // MARK: - Tests for Market Cap
    
    func testMarketCap_USD() {
        XCTAssertEqual(viewModel.marketCap, "USD 511,795,300,923.00")
    }
    
    func ttestMarketCap_MXN() {
        let viewModelUSD = CryptoCoinVM(cryptoCoinData: coinData, currency: .mxn)
        XCTAssertEqual(viewModelUSD.marketCap, "MXN 511,795,300,923.00")
    }
    
    func testMarketCap_EUR() {
        let viewModelUSD = CryptoCoinVM(cryptoCoinData: coinData, currency: .eur)
        XCTAssertEqual(viewModelUSD.marketCap, "EUR 511,795,300,923.00")
    }
    
    func testMarketCap_NaN() {
        let viewModel = CryptoCoinVM(cryptoCoinData: coinDataWithErorr, currency: .eur)
        XCTAssertEqual(viewModel.priceChange24H, "NaN")
    }
    
    // MARK: - Tests for Price Change 24 is Negative
    
    func testPriceChange24HIsNegative_isTrue() {
        XCTAssertEqual(viewModel.priceChange24HIsNegative, true)
    }
    
    func testPriceChange24HIsNegative_isFalse() {
        
        let viewModelWithPriceChangeIsZero = CryptoCoinVM(cryptoCoinData: GeckoCryptoCoin(id: "", symbol: "", name: "", image: "", currentPrice: .zero, lastUpdated:.distantFuture, totalVolume:.zero, high24H:.zero, low24H: .zero, priceChangePercentage24H: .zero, marketCap:.zero), currency: .usd)
        let viewModelWithPriceChangeIsOne = CryptoCoinVM(cryptoCoinData: GeckoCryptoCoin(id: "", symbol: "", name: "", image: "", currentPrice: .zero, lastUpdated:.distantFuture, totalVolume:.zero, high24H:.zero, low24H: .zero, priceChangePercentage24H: 1.0, marketCap:.zero), currency: .usd)
        XCTAssertEqual(viewModelWithPriceChangeIsZero.priceChange24HIsNegative, false)
        XCTAssertEqual(viewModelWithPriceChangeIsOne.priceChange24HIsNegative, false)
    }

}
