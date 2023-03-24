//
//  StoreCategoriesCell.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 23.03.2023.
//

import UIKit

final class StoreCategoriesCell: UICollectionViewCell {
    
    // MARK: - Public properties
    var viewModel: StoreCategoryCellViewModelProtocol! {
        didSet {
            categoryLabel.text = viewModel.name
            categoryImageView.image = UIImage(named: viewModel.image)
        }
    }
    
    // MARK: - Private UI Elements
    private lazy var categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(red: 238/255, green: 239/255, blue: 244/255, alpha: 1)
        imageView.layer.cornerRadius = 20
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 8)
        label.textColor = UIColor(red: 166/255, green: 167/255, blue: 171/255, alpha: 1)
        label.text = "ds"
        return label
    }()
    
    private lazy var categoryStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.addArrangedSubview(categoryImageView)
        stack.addArrangedSubview(categoryLabel)
        return stack
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryImageView.image = nil
        categoryLabel.text = nil
    }
    
    // MARK: - Private methods
    private func configureUI() {
        contentView.addSubview(categoryStackView)
        categoryStackView.translatesAutoresizingMaskIntoConstraints = false
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryImageView.heightAnchor.constraint(equalToConstant: 42),
            categoryImageView.widthAnchor.constraint(equalToConstant: 42),
            categoryStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryStackView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor)
        ])
    }
}
