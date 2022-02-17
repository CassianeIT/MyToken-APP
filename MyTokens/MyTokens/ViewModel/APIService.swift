//
//  APIService.swift
//  MyToken-APP
//
//  Created by Curitiba on 16/02/22.
//

import Foundation
import SwiftUI

class CoinViewModel: ObservableObject {
    
    @Published var coins: [DetailCoin] = [DetailCoin]()
    
//    init()  {
//        fetchCoins(coin: String())
//    }
    
    
    func fetchCoins(coin: String) {
        
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin)")!
        //
        //        URLSession.shared.dataTaskPublisher(for: url)
        //            .map { $0.data }
        //            .decode(type: DetailCoin.self, decoder: JSONDecoder())
        //            .replaceError(with: DetailCoin)
        //            .eraseToAnyPublisher()
        //            .receive(on: DispatchQueue.main)
        //            .assign(to: &$coins)
        //        print(coins)
        //    }
        
        
        //    func getCoins() async {
        // let coin = "bitcoin"
        //    let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin)")!
        //
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Error has occured: \(error.localizedDescription)")
                //                let alert = UIAlertController(title: "A network error has occurred. Check your Internet connection and try again later.", message: nil, preferredStyle: .alert)
                //
                //                let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                //                alert.addAction(cancel)
                
            } else {
                do {
                    let decoder = JSONDecoder()

                    let jsonModel = try decoder.decode(DetailCoin.self, from: data!)
                    print(jsonModel)
                    DispatchQueue.main.async {
                    self.coins = [jsonModel]
                        print(self.coins)
                    //            showData(id: jsonModel.id, symbol: jsonModel.symbol, name: jsonModel.detailCoinDescription, jsonModel.image, jsonModel.marketData)
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
