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
        
        //        let color =
        //        LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .top, endPoint: .bottom)
        //                  .edgesIgnoringSafeArea(.vertical)
        TabView {
            NavigationView {
                VStack {
                    
                    Rectangle()
                        .frame(height: 0)
                        .background(.ultraThinMaterial)
                    
                    
                    List(viewModel.coins) { coin in
                        NavigationLink(destination: DetailCoinView(viewModel: viewModel)){
                            ListItemCell(viewModel: viewModel)
                        }
                        //.listRowBackground(Color.yellow.opacity(0.5))
                    }
                    .onAppear() {
                        UITableView.appearance().backgroundColor = UIColor.white
                    }
                    
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always)
                    )
                    .onSubmit(of: .search) {
                        viewModel.fetchCoins(coin: searchText.lowercased())
                    }
                    
                }
                .background(Color.yellow)
                
                #if !APPCLIP
                .navigationBarTitle("My Tokens".uppercased()).navigationBarTitleDisplayMode(.inline)
                #else
                .navigationBarTitle("My Tokens App Clip".uppercased()).navigationBarTitleDisplayMode(.inline)
                #endif
            }
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
                
            }
            #if !APPCLIP
            Favorites(viewModel: CoinViewModel()).tabItem {
                Label("Favorites", systemImage: "star.circle")
            }
            #endif
            
        } .accentColor(.yellow)
        
        
    }
}


struct ListItemCell: View {
    @ObservedObject var viewModel: CoinViewModel
    
    //  let item: ViewModifier
    
    var body: some View {
        //  Color.purple.ignoresSafeArea()
        ZStack (alignment: .leading) {
            
            Color.yellow
                .frame(height: 100)
                .clipShape(CShape())
                .cornerRadius(15)
                .contentShape(CShape())
            
            HStack {
                AsyncImage(url: URL(string: viewModel.coins[0].image.small)) { image in
                    image.resizable()
                } placeholder: {
                    Color.yellow.opacity(0.5)
                }
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .transition(.scale)
                
                VStack(alignment: .leading, spacing: 0){
                    
                    //  Image(viewModel.coins[0].image)
                    Text("Symbol: \(viewModel.coins[0].symbol.uppercased())").padding(.leading, 15)
                    
                    Text("Name: \(viewModel.coins[0].name)").padding(.leading, 15)
                    
                }
            }.padding(.leading, 30)
        }
    }
}

struct ListCoins_Previews: PreviewProvider {
    static var previews: some View {
        ListCoins(viewModel: CoinViewModel())
    }
}
