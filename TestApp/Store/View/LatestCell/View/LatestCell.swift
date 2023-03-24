//
//  LatestCell.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 24.03.2023.
//

import UIKit
import Kingfisher

final class LatestCell: UICollectionViewCell {
    
    var viewModel: LatestCellViewModelProtocol! {
        didSet {
            let url = URL(string: viewModel.imageUrl)
            productImageView.kf.setImage(with: url)
            categoryLabel.text = viewModel.category
            productNameLabel.text = viewModel.name
            productPriceLabel.text = String(describing: viewModel.price)
        }
    }
    
    // MARK: - Private UI Elements
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.gray.cgColor
        return imageView
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 6, weight: .semibold)
        label.textColor = .black
        label.text = "category"
        return label
    }()
    
    private lazy var productNameView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 10))
        view.backgroundColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
        view.layer.cornerRadius = 7
        view.addSubview(categoryLabel)
        return view
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 9, weight: .semibold)
        label.textColor = .white
        label.text = "name"
        return label
    }()
    
    private lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 7, weight: .semibold)
        label.textColor = .white
        label.text = "price"
        return label
    }()
    
    private lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 229/255, green: 233/255, blue: 239/255, alpha: 1)
        button.layer.cornerRadius = 11
        button.imageView?.contentMode = .scaleAspectFit
        button.configuration = .plain()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = UIColor(red: 84/255, green: 85/255, blue: 137/255, alpha: 1)
        return button
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func configureUI() {
        contentView.addSubview(productImageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productPriceLabel)
        contentView.addSubview(addToCartButton)
        contentView.addSubview(productNameView)
        
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        productPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        productNameView.translatesAutoresizingMaskIntoConstraints = false
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 150),
            productImageView.widthAnchor.constraint(equalToConstant: 114),

            productNameView.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 91),
            productNameView.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor, constant: 7),
            productNameView.trailingAnchor.constraint(lessThanOrEqualTo: productImageView.trailingAnchor, constant: -16),
            
            productNameLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 6),
            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor, constant: 7),
            productNameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: productImageView.trailingAnchor, constant: -16),
            
            productPriceLabel.topAnchor.constraint(lessThanOrEqualTo: productNameLabel.bottomAnchor, constant: 16),
            productPriceLabel.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor, constant: 7),
            
            addToCartButton.topAnchor.constraint(greaterThanOrEqualTo: productImageView.bottomAnchor, constant: 16),
            addToCartButton.leadingAnchor.constraint(lessThanOrEqualTo: productNameLabel.trailingAnchor, constant: 16),
            addToCartButton.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: -5),
            addToCartButton.bottomAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: -5),
            addToCartButton.heightAnchor.constraint(equalToConstant: 20),
            addToCartButton.widthAnchor.constraint(equalToConstant: 20),
            
            categoryLabel.topAnchor.constraint(equalTo: productNameView.topAnchor, constant: 4),
            categoryLabel.bottomAnchor.constraint(equalTo: productNameView.bottomAnchor, constant: -4),
            categoryLabel.leadingAnchor.constraint(equalTo: productNameView.leadingAnchor, constant: 16),
            categoryLabel.trailingAnchor.constraint(equalTo: productNameView.trailingAnchor, constant: -16)
        ])
    }
}
