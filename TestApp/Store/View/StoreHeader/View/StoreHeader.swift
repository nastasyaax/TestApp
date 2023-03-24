//
//  StoreHeader.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 23.03.2023.
//

import UIKit

final class StoreHeader: UITableViewHeaderFooterView {
    
    // MARK: - Private UI Element
    private var searchImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "magnifyingglass")
        imageView.image = image
        imageView.tintColor = .gray
        return imageView
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "What are you looking for?", attributes: [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.systemFont(ofSize: 9, weight: .regular)
        ])
        textField.font = .systemFont(ofSize: 12, weight: .regular)
        textField.rightViewMode = .always
        textField.rightView = searchImage
        textField.layer.cornerRadius = 12
        textField.backgroundColor = UIColor(red: 245/255, green: 246/255, blue: 247/255, alpha: 1)
        textField.textAlignment = .center
        return textField
    }()
    
    // MARK: - Lifecycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func configureUI() {
        contentView.addSubview(searchTextField)
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            searchTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            searchTextField.widthAnchor.constraint(equalToConstant: 262),
            searchTextField.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
