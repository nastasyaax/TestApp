//
//  StoreCategoryCellViewModel.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 24.03.2023.
//

import Foundation

protocol StoreCategoryCellViewModelProtocol {
    var type: StoreCategoryField { get }
    var image: String { get }
    var name: String { get }
}

final class StoreCategoryCellViewModel: StoreCategoryCellViewModelProtocol {
    
    // MARK: - Public properties
    private(set) var type: StoreCategoryField
    var image: String { type.rawValue }
    var name: String { type.image }
    
    // MARK: - Init
    init(type: StoreCategoryField) {
        self.type = type
    }
}
