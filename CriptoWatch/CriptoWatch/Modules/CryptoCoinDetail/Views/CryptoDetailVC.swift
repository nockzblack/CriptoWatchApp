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
        // TODO: Remove Image
        imageView.image = UIImage(systemName: "bitcoinsign.circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let currentPriceLabel: UILabel = {
        let currentPriceLabel = UILabel()
        currentPriceLabel.numberOfLines = 0
        currentPriceLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        currentPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        return currentPriceLabel
    }()
    
    private let symbolLabel: UILabel = {
        let symbolLabel = UILabel()
        symbolLabel.textAlignment = .center
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        return symbolLabel
    }()
    
    private let totalVolume: UILabel = {
        let totalVolume = UILabel()
        totalVolume.numberOfLines = 0
        totalVolume.font = UIFont.systemFont(ofSize: 18, weight: .thin)
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
    
    // MARK: - Object Properties
    
    var viewModel: CryptoCoinVM? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            // Setting up view model
            updateData(with: viewModel)
        }
    }
    
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupView()
        
    }
    
}


private extension CryptoDetailVC {
    
    func updateData(with data: CryptoDetailRepresentable) {
        self.symbolLabel.text = data.symbol
        self.currentPriceLabel.text = data.currentPrice
        self.totalVolume.text = data.totalVolume
        
    }
    
    func setupView() {
        self.view.addSubview(image)
        self.view.addSubview(symbolLabel)
        self.view.addSubview(currentPriceLabel)
        self.view.addSubview(totalVolume)
        
        
        // Layout
        NSLayoutConstraint.activate([
            // Image Layout
            image.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40),
            image.heightAnchor.constraint(equalToConstant: 200),
            image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            image.widthAnchor.constraint(equalTo: image.heightAnchor, multiplier: 1.0),
            
            // Symbol Label Layout
            symbolLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            symbolLabel.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 2),
            
            // Current Price Label Layout
            currentPriceLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            currentPriceLabel.topAnchor.constraint(equalTo: self.symbolLabel.bottomAnchor, constant: 10),
            // Total Volume Label Layout
            totalVolume.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            totalVolume.topAnchor.constraint(equalTo: self.currentPriceLabel.bottomAnchor, constant: 5),
        ])
    }
}
