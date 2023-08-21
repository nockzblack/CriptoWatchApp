//
//  CryptoDetailVC.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 21/08/23.
//

import UIKit

final class CryptoDetailVC: UIViewController {
    
    // MARK: - UI Properties
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let currentPriceLabel: UILabel = {
        let currentPriceLabel = UILabel()
        currentPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        return currentPriceLabel
    }()
    
    private let symbolLabel: UILabel = {
        let symbolLabel = UILabel()
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        return symbolLabel
    }()
    
    private let totalVolume: UILabel = {
        let totalVolume = UILabel()
        totalVolume.translatesAutoresizingMaskIntoConstraints = false
        return totalVolume
    }()
    
    private let highestPrice24H: UILabel = {
        let totalVolume = UILabel()
        totalVolume.translatesAutoresizingMaskIntoConstraints = false
        return totalVolume
    }()
    
    private let lowestPrice24H: UILabel = {
        let totalVolume = UILabel()
        totalVolume.translatesAutoresizingMaskIntoConstraints = false
        return totalVolume
    }()
    
    private let priceChange24H: UILabel = {
        let totalVolume = UILabel()
        totalVolume.translatesAutoresizingMaskIntoConstraints = false
        return totalVolume
    }()
    
    private let marketCap: UILabel = {
        let totalVolume = UILabel()
        totalVolume.translatesAutoresizingMaskIntoConstraints = false
        return totalVolume
    }()
    
    
}


private extension CryptoDetailVC {
    func setupView() {
        self.view.addSubview(image)
        self.view.addSubview(currentPriceLabel)
        self.view.addSubview(symbolLabel)
        
        // Layout
        NSLayoutConstraint.activate([
            // Vertical Layout
            image.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            // Horizontal Layout
            image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            // Set Squar Aspect Ratio
            image.widthAnchor.constraint(equalTo: image.heightAnchor, multiplier: 1.0),
            
            symbolLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            symbolLabel.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 20),
            symbolLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor, constant: 20),
            symbolLabel.trailingAnchor.constraint(greaterThanOrEqualTo: self.view.trailingAnchor, constant: 20),
            
            currentPriceLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            currentPriceLabel.topAnchor.constraint(equalTo: self.symbolLabel.bottomAnchor, constant: 20),
        ])
    }
}
