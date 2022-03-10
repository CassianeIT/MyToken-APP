import SwiftUI
import CoreData


struct DetailList: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @ObservedObject var viewModel: CoinViewModel
    @State private var showingAlert = false
    
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
                            showingAlert = true
                            
                        }, label: {
                            Image(systemName: "star").padding(.trailing, 20)
                        })
                            .alert("Save your favorite cryptos and follow the market.\n Install the App and enjoy all the features.", isPresented: $showingAlert) {
                                Button("OK", role: .cancel) { }
                            }
                    }
                                        
                                            .foregroundColor(Color.yellow))
                    .navigationTitle("\(coins.symbol.uppercased())")
                    .navigationBarTitleDisplayMode(.inline)
                    
                }
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DetailList(viewModel: CoinViewModel())
    }
}
