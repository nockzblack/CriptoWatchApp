//
//  MockNetworkService.swift
//  CriptoWatchUnitTests
//
//  Created by Fernando Benavides on 24/08/23.
//

import Foundation
@testable import CriptoWatch

class MockNetworkService: NetworkService {
    
    // MARK: - Properties
    
    var data: Data?
    var error: Error?
    var statusCode: Int = 200
    
    // MARK: - Network Service
    
    func fetchData(with url: URL, completionHandler: @escaping NetworkService.FetchDataCompletion) {
        // Create Response
        let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        
        completionHandler(data, response, error)
    }
    
}
