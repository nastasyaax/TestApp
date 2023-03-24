//
//  RecentlyViewedItem.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 22.03.2023.
//

import Foundation

struct RecentlyViewedItemModel: Codable {
    let latest: [Latest]
}

// MARK: - Latest
struct Latest: Codable {
    let category, name: String
    let price: Int
    let imageUrl: String
}
