//
//  NetworkManager.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 22.03.2023.
//

import Foundation

final class NetworkManager {
    func fetchLatest(_ completion: @escaping ([Latest]) -> Void) {
        guard let url = URL(string: Server.latestBaseUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            do {
                if let data = data {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let recentlyViewdItemData = try decoder.decode(RecentlyViewedItemModel.self, from: data)
                    let latestDetail = recentlyViewdItemData.latest
                    completion(latestDetail)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
    func fetchFlashSale(_ completion: @escaping ([FlashSale]) -> Void) {
        guard let url = URL(string: Server.flashSaleBaseUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            do {
                if let data = data {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let recentlySaleDetail = try decoder.decode(FlashSaleModel.self, from: data)
                    let saleDetail = recentlySaleDetail.flashSale
                    completion(saleDetail)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
}
