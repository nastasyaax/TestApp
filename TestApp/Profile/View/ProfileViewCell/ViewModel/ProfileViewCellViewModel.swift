//
//  ProfileViewCellViewModel.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 21.03.2023.
//

import Foundation

protocol ProfileViewCellViewModelProtocol {
    var fieldType: ProfileField { get }
    var name: String { get }
    var image: String { get }
}

final class ProfileViewCellViewModel: ProfileViewCellViewModelProtocol {
    
    // MARK: - Public properties
    private(set) var fieldType: ProfileField
    var name: String { fieldType.rawValue }
    var image: String { fieldType.image }
    
    // MARK: - Lifecycle
    init(field: ProfileField) {
        fieldType = field
    }
}
