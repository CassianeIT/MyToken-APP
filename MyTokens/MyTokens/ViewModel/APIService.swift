//
//  APIService.swift
//  MyToken-APP
//
//  Created by Curitiba on 16/02/22.
//

import Foundation
import SwiftUI

class CoinViewModel: ObservableObject {
        
    @Published var coins = [DetailCoin]()
    
//    init()  {
//        self.coins = DetailCoin
//    }
    
    
    func fetchCoins(coin: String) {
        
         let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin)")!
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Error has occured: \(error.localizedDescription)")
                
            } else {
                do {
                    
                    let jsonModel = try JSONDecoder().decode(DetailCoin.self, from: data!)
                    print(jsonModel)
                    DispatchQueue.main.async {
                        self.coins = [jsonModel]
                        print(self.coins)
//                        let viewModel = ViewModel()
//                        viewModel.showData(id: self.coins[0].id, symbol: self.coins[0].symbol, name: self.coins[0].name, detailCoinDescription: self.coins[0].detailCoinDescription, image: self.coins[0].image, marketData: self.coins[0].marketData)
                        
                    }
                } catch  {
                    print("Failed to decode JSON: \(error)")
                }
            }
        }.resume()
    }
    
    
 
    
    //final class ImageCoin {
    //
    //    typealias GRImageDictionary = [String: CGImage]
    //    fileprivate var images: GRImageDictionary = [:]
    //    fileprivate static var scale = 2
    //    static var shared = ImageCoin()
    //
    //    func image(name: String) -> Image {
    //        let index = guaranteeImage(name: name)
    //
    //        return Image(images.values[index], scale: CGFloat(ImageCoin.scale), label: Text(verbatim: name))
    //    }
    //
    //    static func loadPNGImage(name: String) -> CGImage {
    //        guard
    //            let url = Bundle.main.url(forResource: name, withExtension: "png"),
    //            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
    //            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
    //        else {
    //            fatalError("Couldn't load image \(name).png from main bundle.")
    //        }
    //        return image
    //    }
    //    fileprivate func guaranteeImage(name: String) -> GRImageDictionary.Index {
    //        if let index = images.index(forKey: name) { return index }
    //
    //        images[name] = ImageCoin.loadPNGImage(name: name)
    //        return images.index(forKey: name)!
    //    }
}
