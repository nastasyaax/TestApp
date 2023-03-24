//
//  StoreCategoryField.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 23.03.2023.
//

import Foundation

enum StoreCategoryField: String, CaseIterable {
    case phones = "Phones"
    case headPhones = "Headphones"
    case games = "Games"
    case cars = "Cars"
    case furniture = "Furniture"
    case kids = "Kids"
    
    var image: String {
        switch self {
        case .phones:
            return "Phones"
        case .headPhones:
            return "Headphones"
        case .games:
            return "Games"
        case .cars:
            return "Cars"
        case .furniture:
            return "Furniture"
        case .kids:
            return "Kids"
        }
    }
}
