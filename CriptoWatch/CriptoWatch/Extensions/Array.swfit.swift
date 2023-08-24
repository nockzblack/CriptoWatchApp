//
//  Array.swfit.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 24/08/23.
//
extension Array {
    
    subscript(safe index: Int) -> Element? {
        guard indices.contains(index) else {
            return nil
        }
        
        return self[index]
    }
    
}
