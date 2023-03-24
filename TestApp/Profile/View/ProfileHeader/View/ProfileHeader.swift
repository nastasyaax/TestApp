//
//  ProfileHeader.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 17.03.2023.
//

import UIKit

final class ProfileHeader: UITableViewHeaderFooterView {

    //MARK: - Public components
    var viewModel: ProfileHeaderViewModelProtocol! {
        didSet {
            guard let storedImageData = viewModel.profileImage else { return }
            profileImage.image = UIImage(data: storedImageData)
        }
    }
    
    //MARK: - Private UI Elements
    private lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "profile")
        image.backgroundColor = .white
        image.layer.borderColor = CGColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1)
        image.layer.borderWidth = 1
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var changePhotoButton: UIButton = {
        let btn = UIButton()
        btn.setAttributedTitle(NSAttributedString(string: "Change photo", attributes: [
            .foregroundColor: UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1),
            .font: UIFont.systemFont(ofSize: 8, weight: .medium)
        ]), for: .normal)
        btn.addAction(UIAction(handler: { _ in
            self.viewModel.showImagePicker?()
        }), for: .touchUpInside)
        return btn
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Satria Adhi Pradana"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(red: 63/255, green: 63/255, blue: 63/255, alpha: 1)
        return label
    }()
    
    private lazy var uploadItemButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(red: 78/255, green: 85/255, blue: 215/255, alpha: 1)
        btn.setImage(UIImage(named: "upload"), for: .normal)
        btn.setAttributedTitle(NSAttributedString(string: "Upload item", attributes: [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 14, weight: .semibold),

        ]), for: .normal)
        btn.layer.cornerRadius = 15
        btn.imageEdgeInsets.right = 60
        return btn
    }()
    
    private lazy var profileImageStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 8
        stack.addArrangedSubview(profileImage)
        stack.addArrangedSubview(changePhotoButton)
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        changePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        profileImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        changePhotoButton.heightAnchor.constraint(equalToConstant: 8).isActive = true
        return stack
    }()
    
    //MARK: - Lifecycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func setImage(_ image: UIImage) {
        profileImage.image = image
    }
    
    //MARK: - Private methods
    private func configureUI() {
        contentView.addSubview(profileImageStackView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(uploadItemButton)
        contentView.backgroundColor = UIColor(red: 250/155, green: 247/255, blue: 255/255, alpha: 1)
        
        profileImageStackView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        uploadItemButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileImageStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profileImageStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: profileImageStackView.bottomAnchor, constant: 20),
            nameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 150),
            
            uploadItemButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 38),
            uploadItemButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            uploadItemButton.widthAnchor.constraint(equalToConstant: 290),
            uploadItemButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
