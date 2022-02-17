//
//  Coin.swift
//  MyToken-APP
//
//  Created by Curitiba on 16/02/22.
//

import Foundation
import UIKit
import SwiftUI
//
//protocol Detailable {
//    var id: String {get}
//    var symbol: String {get}
//    var name: String {get}
//    var detailCoinDescription: Description {get}
//    var image: Images {get}
//    var marketData: MarketData {get}
//}

//struct Response: Codable {
//    var results: [DetailCoin]
//}



// MARK: - DetailCoin
struct DetailCoin: Identifiable, Codable {
    var id: String
    var symbol: String
    var name: String
    var detailCoinDescription: Description
    var image: Images
    var marketData: MarketData

    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case detailCoinDescription = "description"
        case image
        case marketData = "market_data"
    }
}

// MARK: - Description
struct Description: Codable {
    let en: String
}

// MARK: - Imagesb
struct Images: Codable {
    let small: String
}

// MARK: - MarketData
struct MarketData: Codable {
    let currentPrice: CurrentPrice

    enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
    }
    
    // MARK: - CurrentPrice
    struct CurrentPrice: Codable {
        let brl, usd, eur, btc: Double
    }
}
//
//extension DetailCoin: Detailable {
//    var names: String {
//        return symbol
//    }
//}

//extension Images {
//    var image: CGImage {
//        ImageCoin.loadPNGImage(name: small)
//    }
//}

