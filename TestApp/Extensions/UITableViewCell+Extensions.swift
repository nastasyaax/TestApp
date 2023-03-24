//
//  UITableViewCell+Extension.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 13.03.2023.
//

import UIKit

extension UITableViewCell {
    static var reuseId: String {
        return NSStringFromClass(Self.self)
    }
}
