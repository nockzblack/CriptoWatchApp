//
//  CryptoCoinTableViewCell.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 19/08/23.
//

import UIKit


final class CryptoCoinTableViewCell: UITableViewCell {
    
    // MARK: - Static Properties
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    // MARK: - Properties
    private lazy var imageService = ImageService()
    private var imageRequest: Cancellable?
    
    private let coinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lastUpdatedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Overrides
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Reset thumbnail image view
        coinImageView.image = nil
        
        // Cancel image request
        imageRequest?.cancel()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Public API
extension CryptoCoinTableViewCell {
    func configure(with representable: CryptoCoinRepresentable) {
        nameLabel.text = representable.name
        currentPriceLabel.text = representable.currentPrice
        lastUpdatedLabel.text = "Updated: \(representable.lastUpdated)"
        symbolLabel.text = representable.symbol
        
        guard let validImageUrl = representable.image else {
            coinImageView.image = UIImage(systemName: "dollarsign.circle.fill")
            return
        }
        
        // Request image using image service
        imageRequest = imageService.image(for: validImageUrl) { [weak self] image in
            // Update image view
            self?.coinImageView.image = image
        }
    }
}


// MARK: - Private API
private extension CryptoCoinTableViewCell {
    
    func setupViews() {
        // Defining Stack Views
        let nameAndPriceSV: UIStackView = UIStackView(arrangedSubviews: [nameLabel, currentPriceLabel])
        nameAndPriceSV.spacing = 4
        nameAndPriceSV.axis = .horizontal
        nameAndPriceSV.distribution = .fillProportionally
                                                           
        let infoSV: UIStackView =  UIStackView(arrangedSubviews: [nameAndPriceSV, lastUpdatedLabel])
        infoSV.spacing = 0
        infoSV.axis = .vertical
        infoSV.distribution = .fillEqually
        infoSV.alignment = .leading
        
        let rootSV: UIStackView = UIStackView(arrangedSubviews: [coinImageView, infoSV, symbolLabel])
        rootSV.spacing = 10
        rootSV.axis = .horizontal
        rootSV.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(rootSV)
        let marginGuide = self.contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            // Image
            coinImageView.heightAnchor.constraint(equalTo: coinImageView.widthAnchor, multiplier: 1.0),
            // Root Stack View
            rootSV.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 0),
            rootSV.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: 0),
            rootSV.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 0),
            rootSV.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: 0),
        ])
    }
}
