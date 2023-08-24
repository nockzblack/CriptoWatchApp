//
//  CryptoCoinsListVMTest.swift
//  CriptoWatchUnitTests
//
//  Created by Fernando Benavides on 24/08/23.
//

import XCTest
@testable import CriptoWatch

final class CryptoCoinsListVMTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: CryptoCoinsListVM!
    var networkService: MockNetworkService!
    
    
    // MARK: - Set Up & Tear Down
    
    override func setUpWithError() throws {
        // Initialize Mock Network Service
        networkService = MockNetworkService()
        
        // Configure Mock Network Service
        networkService.data = loadStub(name: "coinGecko", extension: "json")
        
        // Initialize View Model
        viewModel = CryptoCoinsListVM(networkService: networkService)
   }
    
    override func tearDownWithError() throws {
        
    }
    
    // MARK: - Tests for Start Fetching Data
    
    func testStartFetchingData_Success() {
        let expectation = XCTestExpectation(description: "Fetch Crypto Data")
        
        // Install Handler
        viewModel.didFetchCryptoCoinData = { (criptoCoinsData, _) in
            if let cryptos = criptoCoinsData {
                XCTAssertEqual(cryptos.isEmpty, false)
                XCTAssertEqual(cryptos.count, 20)
                
                expectation.fulfill()
            }
        }
        
        // Invoke Method Under Test
        viewModel.startFetchingData()
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testStartFetchingData_NoCryptoDataAvailable() {
        // Configure Network Service
        networkService.error = NSError(domain: "com.cryptoWatch.network.service", code: 1, userInfo: nil)
        let expectation = XCTestExpectation(description: "Fetch Crypto Data")
        
        // Install Handler
        viewModel.didFetchCryptoCoinData = { (_, errorResult) in
            if let error = errorResult {
                XCTAssertEqual(error, CryptoCoinsListVM.CryptoDataError.noCryptoDataAvailable)
                
                expectation.fulfill()
            }
        }
        
        // Invoke Method Under Test
        viewModel.startFetchingData()
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testStartFetchingData_NoResultsFromQuery() {
        // Configure Network Service
        networkService.data = loadStub(name: "coinGeckoEmpty", extension: "json")
        let expectation = XCTestExpectation(description: "Fetch Crypto Data")
        
        // Install Handler
        viewModel.didFetchCryptoCoinData = { (_, errorResult) in
            if let error = errorResult {
                XCTAssertEqual(error, CryptoCoinsListVM.CryptoDataError.noResultsFromQuery)
                
                expectation.fulfill()
            }
        }
        
        // Invoke Method Under Test
        viewModel.startFetchingData()
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    // MARK: - Tests for View Model for Index
    
    func testViewModelForIndex_IndexInRange() {
        viewModel.startFetchingData()
        let cryptoCoinVM = viewModel.viewModel(for: 5)!
        
        XCTAssertNotNil(cryptoCoinVM)
        XCTAssertEqual(cryptoCoinVM.name, "USD Coin")
        XCTAssertEqual(cryptoCoinVM.symbol, "USDC")
    }
    
    func testViewModelForIndex_IndexOutOfRange() {
        viewModel.startFetchingData()
        let cryptoCoinVM = viewModel.viewModel(for: 50)
        
        XCTAssertNil(cryptoCoinVM)
    }
    
    
    // MARK: - Tests for Number Of Cryptos
    
    func testNumberOfCryptos() {
        XCTAssertEqual(viewModel.numberOfCryptos, 0)
        viewModel.startFetchingData()
        
        XCTAssertEqual(viewModel.numberOfCryptos, 20)
    }
    
    // MARK: - Tests for Filter
    
    func testFilterByCripto() {
        viewModel.startFetchingData()
        viewModel.filterCrypto(by: "bitcoin")
        
        XCTAssertEqual(viewModel.numberOfCryptos, 2)
    }
    
    func testRemoveFilter() {
        viewModel.startFetchingData()
        viewModel.filterCrypto(by: "btc")
        viewModel.removeFilter()
        
        XCTAssertEqual(viewModel.numberOfCryptos, 20)
    }
    
    // MARK: - Tests for Sort Crypto Coins
    
    func testSortCryptoCoins_name() {
        viewModel.startFetchingData()
        viewModel.sortCryptoCoins(by: .name)
        
        XCTAssertEqual(viewModel.cryptos.first!.name, "Avalanche")
        XCTAssertEqual(viewModel.cryptos.last!.name, "XRP")
    }
    
    func testSortCryptoCoins_marketCap() {
        viewModel.startFetchingData()
        viewModel.sortCryptoCoins(by: .marketCap)
        
        XCTAssertEqual(viewModel.cryptos.first!.name, "Bitcoin")
        XCTAssertEqual(viewModel.cryptos.last!.name, "Avalanche")
    }
    
    func testSortCryptoCoins_price() {
        viewModel.startFetchingData()
        viewModel.sortCryptoCoins(by: .price)
        
        XCTAssertEqual(viewModel.cryptos.first!.name, "Wrapped Bitcoin")
        XCTAssertEqual(viewModel.cryptos.last!.name, "Shiba Inu")
    }
    
}
