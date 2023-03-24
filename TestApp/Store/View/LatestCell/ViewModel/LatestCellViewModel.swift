//
//  LatestCellViewModel.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 24.03.2023.
//

import Foundation

protocol LatestCellViewModelProtocol {
    var imageUrl: String { get }
    var name: String { get }
    var category: String { get }
    var price: Int { get }
    init(latest: Latest)
}

final class LatestCellViewModel: LatestCellViewModelProtocol {

    var imageUrl: String { latest.imageUrl }
    
    var name: String { latest.name }
    
    var category: String { latest.category }
    
    var price: Int { latest.price }

    private var latest: Latest
    
    init(latest: Latest) {
        self.latest = latest
    }
}
