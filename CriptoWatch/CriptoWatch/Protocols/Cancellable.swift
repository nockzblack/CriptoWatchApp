//
//  Cancellable.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 19/08/23.
//

import Foundation

protocol Cancellable {
    
    // MARK: - Methods
    
    func cancel()
    
}

extension URLSessionTask: Cancellable {
    
}
