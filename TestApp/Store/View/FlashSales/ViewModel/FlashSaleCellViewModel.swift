//
//  FlashSaleCellViewModel.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 24.03.2023.
//

import Foundation

protocol FlashSaleCellViewModelProtocol {
    var imageUrl: String { get }
    var name: String { get }
    var category: String { get }
    var price: Double { get }
    var discount: Int { get }
    init(flashSale: FlashSale)

}

final class FlashSaleCellViewModel: FlashSaleCellViewModelProtocol {
    
    var imageUrl: String { flashSale.imageUrl }
    
    var name: String { flashSale.name }
    
    var category: String { flashSale.category }
    
    var price: Double { flashSale.price }
    
    var discount: Int { flashSale.discount }
    
    private var flashSale: FlashSale
    
    init(flashSale: FlashSale) {
        self.flashSale = flashSale
    }
    
}
