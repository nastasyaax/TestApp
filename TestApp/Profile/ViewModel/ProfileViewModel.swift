//
//  ProfileViewModel.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 21.03.2023.
//

import Foundation

protocol ProfileViewModelProtocol {
    var formatter: DateFormatter { get }
    func numberOfRowsInSection() -> Int
    func cellViewModel(at indexPath: IndexPath) -> ProfileViewCellViewModelProtocol
    func isLogout(at indexPath: IndexPath) -> Bool
}

final class ProfileViewModel: ProfileViewModelProtocol {
    
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "ddhhmmss"
        return formatter
    }
    
    func numberOfRowsInSection() -> Int { ProfileField.allCases.count }
    
    func cellViewModel(at indexPath: IndexPath) -> ProfileViewCellViewModelProtocol {
        let profileField = ProfileField.allCases[indexPath.row]
        return ProfileViewCellViewModel(field: profileField)
    }
    
    func isLogout(at indexPath: IndexPath) -> Bool {
        ProfileField.allCases[indexPath.row] == .logout
    }
}
