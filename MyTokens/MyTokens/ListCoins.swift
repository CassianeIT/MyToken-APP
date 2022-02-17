//
//  ListCoins.swift
//  MyTokens
//
//  Created by Curitiba on 17/02/22.
//

import SwiftUI

struct ListCoins: View {
    
    @ObservedObject var viewModel: CoinViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.coins) { coin in
                NavigationLink(destination: DetailCoinView(viewModel: viewModel)) {
                    Text(coin.symbol.uppercased())
                    Spacer()
                    Text(coin.name)
                }.navigationTitle("Pesquise sua criptomoeda").navigationBarTitleDisplayMode(.inline)
            }
            .task {
                viewModel.fetchCoins(coin: "bitcoin")
            }
        }
    }
}


struct ListCoins_Previews: PreviewProvider {
    static var previews: some View {
        ListCoins(viewModel: CoinViewModel())
    }
}
