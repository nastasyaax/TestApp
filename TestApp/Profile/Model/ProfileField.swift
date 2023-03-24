//
//  ProfileField.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 20.03.2023.
//

import Foundation

enum ProfileField: String, CaseIterable {
    case tradeStore = "Trade store"
    case paymentMethod = "Payment method"
    case balance = "Balance"
    case tradeHistory = "Trade history"
    case restorePurchase = "Restore purchase"
    case help = "Help"
    case logout = "Log out"
    
    var image: String {
        switch self {
        case .tradeStore, .paymentMethod, .balance, .tradeHistory:
            return "Trade store"
        case .restorePurchase:
            return "Restore purchase"
        case .help:
            return "Help"
        case .logout:
            return "Log out"
        }
    }
}
