//
//  Coin.swift
//  MyToken-APP
//
//  Created by Curitiba on 16/02/22.
//

import Foundation
import UIKit
import SwiftUI

struct Response: Codable {
    var results: [DetailCoin]
}

// MARK: - DetailCoin
struct DetailCoin: Codable {
    let id, symbol, name: String
    let detailCoinDescription: Description
    let image: Images
    let marketData: MarketData

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
        let brl, usd, eur, btc: Int
    }
}


//extension Images {
//    var image: CGImage {
//        ImageCoin.loadPNGImage(name: small)
//    }
//}

