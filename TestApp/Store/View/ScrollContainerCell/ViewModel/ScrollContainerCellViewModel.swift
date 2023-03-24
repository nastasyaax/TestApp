//
//  ScrollContainerCellViewModel.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 24.03.2023.
//

import Foundation

protocol ScrollContainerCellViewModelProtocol {
    var type: StoreField { get }
    var numberOfItems: Int { get }
    var sizeForItems: CGSize { get }
    init(type: StoreField)
//    func storeCategoryCellViewModel(at indexPath: IndexPath) -> StoreCategoryCellViewModelProtocol
//    func latestCellViewModel(at indexPath: IndexPath) -> LatestCellViewModelProtocol
//    func flashSaleCellViewModel(at indexPath: IndexPath) -> FlashSaleCellViewModelProtocol
}

final class ScrollContainerCellViewModel: ScrollContainerCellViewModelProtocol {
    
    // MARK: - Public properties
    private(set) var type: StoreField
    
    var numberOfItems: Int {
        switch type {
        case .categories:
            return StoreCategoryField.allCases.count
        case .latest:
            return latest.count
        case .flashSale:
            return flashSale.count
        case .brands:
            return latest.count
        }
    }
    
    var sizeForItems: CGSize {
        CGSize(width: type.width, height: type.height)
    }
    
    // MARK: - Private properties
    private var latest: [Latest] = [
        Latest(
            category: "Cars",
            name: "BMW X6M",
            price: 35000,
            imageUrl: "https://mirbmw.ru/wp-content/uploads/2022/01/manhart-mhx6-700-01.jpg"),
        Latest(
            category: "Cars",
            name: "BMW X6M",
            price: 35000,
            imageUrl: "https://mirbmw.ru/wp-content/uploads/2022/01/manhart-mhx6-700-01.jpg"),
        Latest(
            category: "Cars",
            name: "BMW X6M",
            price: 35000,
            imageUrl: "https://mirbmw.ru/wp-content/uploads/2022/01/manhart-mhx6-700-01.jpg"),
        Latest(
            category: "Cars",
            name: "BMW X6M",
            price: 35000,
            imageUrl: "https://mirbmw.ru/wp-content/uploads/2022/01/manhart-mhx6-700-01.jpg")
    ]
    
    private var flashSale: [FlashSale] = [
        FlashSale(
            category: "Kids",
            name: "New Balance Sneakers",
            price: 22.5,
            discount: 30,
            imageUrl: "https://newbalance.ru/upload/iblock/697/iz997hht_nb_02_i.jpg"),
        FlashSale(
            category: "Kids",
            name: "New Balance Sneakers",
            price: 22.5,
            discount: 30,
            imageUrl: "https://newbalance.ru/upload/iblock/697/iz997hht_nb_02_i.jpg"),
        FlashSale(
            category: "Kids",
            name: "New Balance Sneakers",
            price: 22.5,
            discount: 30,
            imageUrl: "https://newbalance.ru/upload/iblock/697/iz997hht_nb_02_i.jpg"),
        FlashSale(
            category: "Kids",
            name: "New Balance Sneakers",
            price: 22.5,
            discount: 30,
            imageUrl: "https://newbalance.ru/upload/iblock/697/iz997hht_nb_02_i.jpg")
    ]
    // MARK: - Init
    init(type: StoreField) {
        self.type = type
    }
    
    // MARK: - Public methods
//    func storeCategoryCellViewModel() -> StoreCategoryCellViewModelProtocol {
//        let storeCategory = StoreCategoryField.allCases[indexPath.row]
//        return StoreCategoryCellViewModel(storeCategoryField: storeCategory)
//    }
//
//    func latestCellViewModel() -> LatestCellViewModelProtocol {
//        let latest = latest[indexPath.row]
//        return LatestCellViewModel(latest: latest)
//    }
//
//    func flashSaleCellViewModel() -> FlashSaleCellViewModelProtocol {
//        let flashSale = flashSale[indexPath.row]
//        return FlashSaleCellViewModel(flashSale: flashSale)
//    }
}
