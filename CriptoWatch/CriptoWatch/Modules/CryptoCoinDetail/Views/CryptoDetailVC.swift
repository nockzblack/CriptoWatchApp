//
//  CryptoDetailVC.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 21/08/23.
//

import UIKit

final class CryptoDetailVC: UIViewController {
    
    // MARK: - UI Properties
    private let cryptoCoinImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let currentPriceLabel: UILabel = {
        let currentPriceLabel = UILabel()
        currentPriceLabel.numberOfLines = 0
        currentPriceLabel.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
        currentPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        return currentPriceLabel
    }()
    
    private let symbolLabel: UILabel = {
        let symbolLabel = UILabel()
        symbolLabel.textAlignment = .center
        symbolLabel.font = UIFont.systemFont(ofSize: 22, weight: .ultraLight)
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        return symbolLabel
    }()
    
    
    private let totalVolume: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let volumeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Volume"
        label.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let marketCap: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let marketCapLabel: UILabel = {
        let label = UILabel()
        label.text = "Market Cap"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let highestPrice24H: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .systemTeal
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let highestPrice24HLabel: UILabel = {
        let label = UILabel()
        label.text = "24H Highest"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lowestPrice24H: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .systemIndigo
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let lowestPrice24HLabel: UILabel = {
        let label = UILabel()
        label.text = "24H Lowest"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceChange24H: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let priceChange24HLabel: UILabel = {
        let label = UILabel()
        label.text = "24H Change"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - Object Properties
    
    var viewModel: CryptoCoinVM? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            // Setting up view model
            updateData(with: viewModel)
        }
    }
    private lazy var imageService = ImageService()
    private var imageRequest: Cancellable?
    
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupView()
        
    }
    
    // MARK: - Deinitialization
    
    deinit {
        // Cancel Data Task
        imageRequest?.cancel()
    }
    
}


private extension CryptoDetailVC {
    
    func updateData(with data: CryptoDetailRepresentable) {
        self.title = data.name
        self.symbolLabel.text = data.symbol
        self.currentPriceLabel.text = data.currentPrice
        self.totalVolume.text = data.totalVolume
        self.marketCap.text = data.marketCap
        self.highestPrice24H.text = data.hightest24H
        self.lowestPrice24H.text = data.lowest24H
        self.priceChange24H.text = data.priceChange24H
        self.priceChange24H.textColor = data.priceChange24HIsNegative ? .systemRed : .systemGreen
        
        
        guard let validImageUrl = data.image else {
            cryptoCoinImage.image = UIImage(systemName: "dollarsign.circle.fill")
            return
        }
        
        // Request image using image service
        imageRequest = imageService.image(for: validImageUrl) { [weak self] image in
            // Update image view
            self?.cryptoCoinImage.image = image
        }
        
    }
    
    func setupView() {
        self.view.addSubview(cryptoCoinImage)
        self.view.addSubview(symbolLabel)
        self.view.addSubview(currentPriceLabel)
        
        
        // Defining Stack Views
        let views: [UIView] = [totalVolume, volumeLabel, marketCap, marketCapLabel, highestPrice24H, highestPrice24HLabel, lowestPrice24H, lowestPrice24HLabel, priceChange24H, priceChange24HLabel]
        let criptoDetailsSV: UIStackView = UIStackView(arrangedSubviews: views)
        criptoDetailsSV.spacing = 6
        criptoDetailsSV.axis = .vertical
        criptoDetailsSV.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(criptoDetailsSV)
        
        
        // Layout
        NSLayoutConstraint.activate([
            // Image Layout
            cryptoCoinImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40),
            cryptoCoinImage.heightAnchor.constraint(equalToConstant: 150),
            cryptoCoinImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            cryptoCoinImage.widthAnchor.constraint(equalTo: cryptoCoinImage.heightAnchor, multiplier: 1.0),
            
            // Symbol Label Layout
            symbolLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            symbolLabel.topAnchor.constraint(equalTo: self.cryptoCoinImage.bottomAnchor, constant: 4),
            
            // Current Price Label Layout
            currentPriceLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            currentPriceLabel.topAnchor.constraint(equalTo: self.symbolLabel.bottomAnchor, constant: 10),
            
            // Total Volume Label Layout
            criptoDetailsSV.topAnchor.constraint(equalTo: self.currentPriceLabel.bottomAnchor, constant: 40),
            criptoDetailsSV.bottomAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            criptoDetailsSV.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            criptoDetailsSV.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
    }
}
