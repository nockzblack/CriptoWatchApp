//
//  NetworkService.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 24/08/23.
//

import Foundation


protocol NetworkService {
    
    // MARK: - Type Aliases
    
    typealias FetchDataCompletion = (Data?, URLResponse?, Error?) -> Void
    
    // MARK: - Methods
    
    func fetchData(with url: URL, completionHandler: @escaping FetchDataCompletion)
    
}
