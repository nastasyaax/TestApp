//
//  UICollectionViewCell+Extensions.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 23.03.2023.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static var reuseId: String {
        return NSStringFromClass(Self.self)
    }
}
