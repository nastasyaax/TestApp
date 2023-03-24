//
//  StoreField.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 23.03.2023.
//

import Foundation

enum StoreField: Int, CaseIterable {
    case categories
    case latest
    case flashSale
    case brands
    
    var title: String {
        switch self {
        case .categories:
            return ""
        case .latest:
            return "Latest"
        case .flashSale:
            return "Flash Sale"
        case .brands:
            return "Brands"
        }
    }
    
    var height: CGFloat {
        switch self {
        case .categories:
            return 64
        case .latest, .brands:
            return 168
        case .flashSale:
            return 242
        }
    }
    
    var width: CGFloat {
        switch self {
        case .categories:
            return 42
        case .latest, .brands:
            return 114
        case .flashSale:
            return 174
        }
    }
    
    var itemSpacing: CGFloat {
        switch self {
        case .categories:
            return 20
        case .latest, .brands:
            return 12
        case .flashSale:
            return 8
        }
    }
}
