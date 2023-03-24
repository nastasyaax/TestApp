//
//  FlashSaleModel.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 22.03.2023.
//

import Foundation

// MARK: - FlashSaleModel
struct FlashSaleModel: Codable {
    let flashSale: [FlashSale]
}

// MARK: - FlashSale
struct FlashSale: Codable {
    let category, name: String
    let price: Double
    let discount: Int
    let imageUrl: String
}
