//
//  ProfileViewCell.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 17.03.2023.
//

import UIKit

final class ProfileViewCell: UITableViewCell {
    
    // MARK: - Public properties
    var viewModel: ProfileViewCellViewModelProtocol! {
        didSet {
            nameLabel.text = viewModel.name
            iconImageView.image = UIImage(named: viewModel.image)
            makeUI(for: viewModel.fieldType)
        }
    }
    
    //MARK: - Private UI Elements
    private lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor(red: 238/255, green: 239/255, blue: 244/255, alpha: 1)
        image.layer.cornerRadius = 20
        image.tintColor = .black
        return UIImageView()
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var additionalInformationLabel: UILabel = {
        let label = UILabel()
        label.text = "$ 1593"
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 13, weight: .black))
        let arrowImage = UIImage(systemName: "chevron.right", withConfiguration: config)
        let image = UIImageView(image: arrowImage)
        image.tintColor = .black
        return image
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    private func makeUI(for field: ProfileField) {
        switch field {
        case .tradeStore, .paymentMethod, .tradeHistory, .restorePurchase:
            contentView.addSubview(arrowImageView)
            arrowImageView.translatesAutoresizingMaskIntoConstraints = false
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            arrowImageView.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: 16).isActive = true
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40).isActive = true
        case .balance:
            contentView.addSubview(additionalInformationLabel)
            additionalInformationLabel.translatesAutoresizingMaskIntoConstraints = false
            additionalInformationLabel.translatesAutoresizingMaskIntoConstraints = false
            additionalInformationLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            additionalInformationLabel.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: 16).isActive = true
            additionalInformationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40).isActive = true
        case .help, .logout:
            break
        }
    }
    
    private func configureUI() {
        selectionStyle = .none
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        contentView.backgroundColor = UIColor(red: 250/155, green: 247/255, blue: 255/255, alpha: 1)

        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}
