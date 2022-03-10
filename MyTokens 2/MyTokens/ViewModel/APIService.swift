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
 //   private var tasks: Set<DetailCoin>

    
//    init()  {
//        self.coins = DetailCoin
//    }

    func fetchCoins(coin: String) {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin)") else {return}
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Error has occured: \(error.localizedDescription)")
                
            } else {
                do {
                    
                    let jsonModel = try JSONDecoder().decode(DetailCoin.self, from: data!)
                    print(jsonModel)
                    DispatchQueue.main.async {
                        self.coins = [jsonModel]
                    //b    self.tasks = jsonModel
                      //  print(self.coins)
//                        let viewModel = ViewModel()
//                        viewModel.showData(id: self.coins[0].id, symbol: self.coins[0].symbol, name: self.coins[0].name, detailCoinDescription: self.coins[0].detailCoinDescription, image: self.coins[0].image, marketData: self.coins[0].marketData)
                        
                    }
                } catch  {
                    print("Failed to decode JSON: \(error)")
                }
            }
        }.resume()
    }
    
//    func add(_ task: DetailCoin) {
//        objectWillChange.send()
//        tasks.insert(task.id)
//        save()
//    }
//    
//    func remove(_ task: DetailCoin) {
//        objectWillChange.send()
//        tasks.remove(tasks.id)
//        save()
//    }
//    
//    func save() {
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(DetailCoin) {
//            defaults.set(encoded, forKey: "CoinViewModel")
//        }
//    }
 
}
