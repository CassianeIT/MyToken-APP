import SwiftUI


struct DetailCoinView: View {
    
    @ObservedObject var viewModel: CoinViewModel
    @State private var showDetails = true
    @State private var showingAlert = false
    
    
    @State private var messageAlert = "Cryptocurrency removed from your favorites"
    var coinSymbol = String()
    var coinPriceBRL = Double()
    var coinPriceUSD = Double()
    var coinPriceEUR = Double()
    var coinPriceBTC = Double()
    
    
    
    var body: some View {

        let coins = viewModel.coins[0]
            
        NavigationView{
             List(viewModel.coins) { item in
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
                        showDetails.toggle()
                        
                        if showDetails {
                            showingAlert = true
                        }
                        
                    }, label: {
                        if showDetails {
                            Image(systemName: "star").padding(.trailing, 20)
                            
                        } else {
                            ZStack(alignment: .topLeading) {
                                LottieView(name: "starAnimation", loopMode: .playOnce)
                                    .frame(width: 70, height: 70, alignment: .trailing)
                            }
                        }})
                        .alert(messageAlert, isPresented: $showingAlert) {
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
//
//func delegateFavorite() {
//
//    .alert("Important message", isPresented: $showingAlert) {
//        Button("OK", role: .cancel) { }
//    }
//
//    print("hrlo")
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCoinView(viewModel: CoinViewModel())
    }
}
