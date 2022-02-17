//
//  APIService.swift
//  MyToken-APP
//
//  Created by Curitiba on 16/02/22.
//

import Foundation
import UIKit
import SwiftUI

class APIService: UIViewController {
    
    func getCoins() async {
        let coin = "bitcoin"
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin)")!
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            if let error = error {
                print(error)
                let alert = UIAlertController(title: "A network error has occurred. Check your Internet connection and try again later.", message: nil, preferredStyle: .alert)
                
                let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                do {
                    let jsonModel = try JSONDecoder().decode([DetailCoin].self, from: data!)
                    print(jsonModel)
                    //            showData(id: jsonModel.id, symbol: jsonModel.symbol, name: jsonModel.detailCoinDescription, jsonModel.image, jsonModel.marketData)
                    
                } catch  {
                    print("Failed to decode JSON: \(error.localizedDescription)")
                }
            }
        }).resume()
    }
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
//}
