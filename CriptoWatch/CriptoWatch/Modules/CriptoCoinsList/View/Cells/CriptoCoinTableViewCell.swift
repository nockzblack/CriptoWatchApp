//
//  CriptoCoinTableViewCell.swift
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
    func configure(with coin: GeckoCriptoCoin?) {
        nameLabel.text = coin?.name
        currentPriceLabel.text = "\(coin!.current_price)"
        lastUpdatedLabel.text = "Updated: \(coin!.last_updated)"
        symbolLabel.text = coin?.symbol
        
        let url = URL(string: coin?.image ?? "")
        // Request image using image service
        imageRequest = imageService.image(for: url!) { [weak self] image in
            // Update thumbnail image view
            self?.coinImageView.image = image
        }
    }
}


// MARK: - Private API
private extension CryptoCoinTableViewCell {
    
    func setupViews() {
        contentView.addSubview(coinImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(currentPriceLabel)
        contentView.addSubview(lastUpdatedLabel)
        contentView.addSubview(symbolLabel)
        
        
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
        
        NSLayoutConstraint.activate([
            // Image
            coinImageView.widthAnchor.constraint(equalToConstant: 50),
            coinImageView.heightAnchor.constraint(equalToConstant: 50),
            // Root Stack View
            rootSV.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            rootSV.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            rootSV.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            rootSV.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
        ])
    }
}
