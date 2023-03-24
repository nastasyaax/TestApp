//
//  CollectionTableViewCell.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 23.03.2023.
//

import UIKit

final class ScrollContainerCell: UITableViewCell {
    
    // MARK: - Public properties
    var viewModel: ScrollContainerCellViewModelProtocol!
    
    // MARK: - Private UI Elements
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: contentView.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 250/155, green: 247/255, blue: 255/255, alpha: 1)
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.register(StoreCategoriesCell.self, forCellWithReuseIdentifier: StoreCategoriesCell.reuseId)
        collectionView.register(LatestCell.self, forCellWithReuseIdentifier: LatestCell.reuseId)
        collectionView.register(FlashSaleCell.self, forCellWithReuseIdentifier: FlashSaleCell.reuseId)
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func configureUI() {
        backgroundColor = UIColor(red: 250/155, green: 247/255, blue: 255/255, alpha: 1)
        contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

// MARK: - Extensions
extension ScrollContainerCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.type {
        case .categories:
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoreCategoriesCell.reuseId, for: indexPath) as? StoreCategoriesCell else {
                return UICollectionViewCell()
            }
            return cell
        case .latest, .brands:
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LatestCell.reuseId, for: indexPath) as? LatestCell else {
                return UICollectionViewCell()
            }
            return cell
        case .flashSale:
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlashSaleCell.reuseId, for: indexPath) as? FlashSaleCell else {
                return UICollectionViewCell()
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel.sizeForItems
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        viewModel.type.itemSpacing
    }
}

