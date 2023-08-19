//
//  CriptoCoinTableViewCell.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 19/08/23.
//

import UIKit


final class CryptoCoinTableViewCell: UITableViewCell {
    
    // MARK: - Properties
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
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        NSLayoutConstraint.activate([
            // Image
            coinImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            coinImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            coinImageView.widthAnchor.constraint(equalToConstant: 40),
            coinImageView.heightAnchor.constraint(equalToConstant: 40),
            // Name
            nameLabel.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            // Price
            currentPriceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            currentPriceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            // Las updated
            lastUpdatedLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            lastUpdatedLabel.topAnchor.constraint(equalTo: currentPriceLabel.bottomAnchor, constant: 4),
            // Symbol
            symbolLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            symbolLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
