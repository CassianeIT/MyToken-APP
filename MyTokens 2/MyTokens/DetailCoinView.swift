import SwiftUI
import CoreData


struct DetailCoinView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @ObservedObject var viewModel: CoinViewModel
    @State private var controleFavorites = true
    @State private var showingAlert = false
    @State var isFavorite = false
    @State private var messageAlert = "Cryptocurrency removed from your favorites"
    @State var favoritesCoreData: [NSManagedObject] = []
    
    @FetchRequest(
        entity: Coin.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Coin.coinName, ascending: true),
        ]
    ) var coinNames: FetchedResults<Coin>
    
    var body: some View {
        
        let coins = viewModel.coins[0]
        
        NavigationView{
            List {
                ForEach(viewModel.coins, id: \.id) { item in
                    //   (viewModel.coins) { item in
                    VStack(alignment: .leading) {
                        // Color.purple.ignoresSafeArea()
                        Text(coins.symbol.uppercased())
                            .font(.headline)
                        
                        Text("Name: \(coins.name)")
                        Spacer()
                        Text("Price in USD: \(coins.marketData.currentPrice.usd)")
                        Text("Price in EUR: \(coins.marketData.currentPrice.eur)")
                        Text("Price in BRL: \(coins.marketData.currentPrice.brl)")
                        Text("Price in BTC: \(coins.marketData.currentPrice.btc)")
                        Spacer()
                        Text("Description:\n\(coins.detailCoinDescription.en)")  .multilineTextAlignment(.leading)
                            .lineLimit(50)
                        
                    }
                    //.background(Color.yellow.opacity(0.5))
                    .padding()
                    .border(Color.yellow, width: 5)
                    .navigationBarItems(leading: HStack{
                        AsyncImage(url: URL(string: viewModel.coins[0].image.small)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.white
                        }
                        .frame(width: 30, height: 30)
                        .clipShape(RoundedRectangle(cornerRadius: 15)).padding(.leading, 130)
                        
                    }, trailing: HStack {
                        
                        Button(action: {
                            
                            controleFavorites.toggle()
                            
                            if controleFavorites {
                                showingAlert = true
                                isFavorite = false
                                
                            } else {
                                #if APPCLIP
                                showingAlert = true
                                #endif
                                isFavorite = true
                                let coinName = Coin(context: managedObjectContext)
                                coinName.coinName = coins.name
                                coinName.coinPrice = coins.marketData.currentPrice.usd
                                do {
                                    try managedObjectContext.save()
                                    print(coinName.coinPrice)
                                } catch {
                                    print("Falha ao salvar")
                                }
                                
                            }
                            
                        }, label: {
                            if controleFavorites {
                                Image(systemName: "star").padding(.trailing, 20)
                                
                            } else {
                                #if !APPCLIP
                                ZStack(alignment: .topLeading) {
                                    LottieView(name: "starAnimation", loopMode: .playOnce)
                                        .frame(width: 70, height: 70, alignment: .trailing)
                                }
                                #endif
                                
                                #if APPCLIP
                                Image(systemName: "star.fill").padding(.trailing, 20)
                                #endif
                                
                                
                                
                            }
                            
                        })
                        #if APPCLIP
                            .alert("Install the full version of the App and enjoy all the benefits.", isPresented: $showingAlert) {
                                Button("OK", role: .cancel) { }
                            }
                        #endif
                        
                        #if !APPCLIP

                            .alert(messageAlert, isPresented: $showingAlert) {
                                Button("OK", role: .cancel) { }
                            }
                        #endif
                        
                    }
                                        
                                            .foregroundColor(Color.yellow))
                    .navigationTitle("\(coins.symbol.uppercased())")
                    .navigationBarTitleDisplayMode(.inline)
                    
                }
                // .onDelete(perform: deleteCoin)
            }
            
        }
        
    }
    
    //    func deleteCoin(at offsets: IndexSet) {
    //        for index in offsets {
    //            let coinNames = coinNames[index]
    //            managedObjectContext.delete(coinNames)
    //        }
    //    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCoinView(viewModel: CoinViewModel())
    }
}
