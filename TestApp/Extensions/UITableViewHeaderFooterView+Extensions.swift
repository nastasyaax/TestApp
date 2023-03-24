//
//  UITableViewHeaderFooterView+Extensions.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 17.03.2023.
//

import Foundation
import UIKit

extension UITableViewHeaderFooterView {
    static var reuseId: String {
        return NSStringFromClass(Self.self)
    }
}
