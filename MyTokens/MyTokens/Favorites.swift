//
//  Favorites.swift
//  MyTokens
//
//  Created by Curitiba on 18/02/22.
//

import SwiftUI
import CoreData

struct Favorites: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    //  @ObservedObject var viewModel: CoinViewModel
    @State private var searchText = ""
    @State private var buttoEdit = "Delete"
    @State private var editOrDone = false
    
    @State var favoritesTeste : [DetailCoin] = []
    @State var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
    @FetchRequest(
        entity: Coin.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Coin.coinName, ascending: true),
        ]
    ) var coinNames: FetchedResults<Coin>
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                
                LazyVGrid(columns: columns,spacing: 20){
                    ForEach(coinNames,id: \.id){coinsIndex in
                        
                        VStack(spacing: 15){
                            ZStack {
                                
                                Color.yellow
                                    .frame(height: 180)
                                    .clipShape(CShape())
                                    .cornerRadius(15)
                                    .contentShape(CShape())
                                
                                if buttoEdit == "Done" {
                                    VStack {
                                        Button(action: {

                                            withAnimation { () -> () in
                                                guard let index: Int = coinNames.firstIndex(of: coinsIndex) else {return}
                                                
                                                deleteCoin(index:index)
                                                do {
                                                    try managedObjectContext.save()
                                                } catch {
                                                    print("Falha ao salvar")
                                                }
                                            }
                                        }){
                                            Text("✕")
                                                .foregroundColor(.white)
                                                .frame(width:30,height:30)
                                                .background(Color.red)
                                                .cornerRadius(100)
                                            // .offset(x:20,y:-20)
                                        }
                                        .padding(.bottom, 110)
                                    } .padding(.leading, 100)
                                }
                                
                                VStack {
                                    Text(coinsIndex.coinName ?? "Falha ao obter Coin")
                                    //                                Text("\(coinsIndex.symbol.uppercased())\nName: \(coinsIndex.name)\nPrice USD: \(coinsIndex.prices["usd"]!)")
                                    //                                    .fontWeight(.bold)
                                    //                                    .multilineTextAlignment(.center)
                                    //                                    .foregroundColor(.white)
                                    //                                    .padding(.horizontal)
                                }
                            }
                        
                        }
                        .toolbar {
                            //EditButton()
                            ToolbarItemGroup(placement: .primaryAction) {
                                Button(buttoEdit) {
                                    if editOrDone {
                                        buttoEdit = "Done"
                                        editOrDone.toggle()
                                    } else {
                                        buttoEdit = "Delete"
                                        editOrDone.toggle()
                                    }
                                }
                            }
                        }
                    }
                }
                
                .padding(.horizontal)
                .padding(.bottom)
            }
            
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.inline)
            //    .background(Color.yellow)
            //  .accentColor(.yellow)
        }
        
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always)
        )
        .onSubmit(of: .search) {
            //viewModel.fetchCoins(coin: searchText.lowercased())
        }
    }
    
    
    func deleteCoin(index: Int) {
        let coinNames = coinNames[index]
        managedObjectContext.delete(coinNames)
    }
}


struct CShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topRight,.bottomLeft], cornerRadii: CGSize(width: 55, height: 55))
        
        return Path(path.cgPath)
    }
}


struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        Favorites()
    }
}
