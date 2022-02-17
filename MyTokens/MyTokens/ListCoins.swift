//
//  ListCoins.swift
//  MyTokens
//
//  Created by Curitiba on 17/02/22.
//

import SwiftUI

struct ListCoins: View {
    
    @ObservedObject var viewModel: CoinViewModel
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List(viewModel.coins) { coin in
                NavigationLink(destination: DetailCoinView(viewModel: viewModel)) {
                    Text(coin.symbol.uppercased())
                    Spacer()
                    Text(coin.name)
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always)
            )
            .onSubmit(of: .search) {
                viewModel.fetchCoins(coin: searchText.lowercased())
              //  List.refreshable()
            }
            .navigationTitle("My Tokens".uppercased()).navigationBarTitleDisplayMode(.inline)
            
//            .task {
//                
//            }
        }
    }
}


struct ListCoins_Previews: PreviewProvider {
    static var previews: some View {
        ListCoins(viewModel: CoinViewModel())
    }
}
