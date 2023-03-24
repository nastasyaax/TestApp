//
//  ProfileHeaderViewModel.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 22.03.2023.
//

import Foundation

protocol ProfileHeaderViewModelProtocol {
    var showImagePicker: (() -> Void)? { get set }
    var profileImage: Data? { get }
}

final class ProfileHeaderViewModel: ProfileHeaderViewModelProtocol {
    var showImagePicker: (() -> Void)?
    var profileImage: Data? { UserDefaults.standard.data(forKey: UserDefaultsConstant.avatar) }
}
