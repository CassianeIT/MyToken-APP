import SwiftUI



struct DetailCoinView: View {
    
    @ObservedObject var viewModel: CoinViewModel
    
    var body: some View {
        NavigationView{
            List(viewModel.coins) { item in
                VStack(alignment: .leading) {
                    Text(item.symbol.uppercased())
                        .font(.headline)
                    VStack(alignment: .leading) {
                        Text("Name: \(item.name)")
                        Spacer()
                        Text("Price in BRL: \(item.marketData.currentPrice.brl)")
                        Text("Price in USD: \(item.marketData.currentPrice.usd)")
                        Text("Price in EUR: \(item.marketData.currentPrice.eur)")
                        Text("Price in BTC: \(item.marketData.currentPrice.btc)")
                        Spacer()
                        Text("Description: \(item.detailCoinDescription.en)")
                        
                    }.navigationTitle("My Tokens")
                }
            }
        }
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            DetailCoinView(viewModel: CoinViewModel())
            //  DetailCoinView()
        }
    }
