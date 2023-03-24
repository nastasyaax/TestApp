//
//  StoreViewModel.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 23.03.2023.
//

import Foundation

protocol StoreViewModelProtocol {
    var numberOfRows: Int { get }
    init(networkManager: NetworkManager)
    func fetchAllData(_ completion: @escaping ((_ isSuccess: Bool) -> Void))
    func cellViewModel(at indexPath: IndexPath) -> ScrollContainerCellViewModelProtocol
    func rowHeight(at indexPath: IndexPath) -> CGFloat
}

final class StoreViewModel: StoreViewModelProtocol {
    
    // MARK: - Public properties
    var numberOfRows: Int { StoreField.allCases.count }
    
    // MARK: - Private properties
    private var networkManager: NetworkManager
    private var latests: [Latest] = []
    private var flashSales: [FlashSale] = []
    
    // MARK: - Lifecycle
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    // MARK: - Public methods
    func fetchAllData(_ completion: @escaping ((_ isSuccess: Bool) -> Void)) {
        networkManager.fetchLatest { [weak self] latest in
            self?.networkManager.fetchFlashSale { [weak self] sales in
                DispatchQueue.main.async {
                    print(sales)
                    print(latest)
                    self?.latests = latest
                    self?.flashSales = sales
                    completion(true)
                }
            }
        }
    }
    
    func cellViewModel(at indexPath: IndexPath) -> ScrollContainerCellViewModelProtocol {
        ScrollContainerCellViewModel(type: .allCases[indexPath.row])
    }
    
    func rowHeight(at indexPath: IndexPath) -> CGFloat {
        StoreField.allCases[indexPath.row].height
    }
}
