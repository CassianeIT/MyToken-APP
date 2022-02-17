import SwiftUI

struct ContentView: View {
    
    @State private var results = [DetailCoin]()
    
    var body: some View {
       
            
        
    NavigationView{
        List(results, id: \.id) { item in
            VStack(alignment: .leading) {
                Text(item.symbol.uppercased())
                .font(.headline)
           
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
        .task {
            await getCoins()
        }
    }
    
    func getCoins() async {
        let coin = "bitcoin"
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin)")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let jsonModel = try? JSONDecoder().decode(DetailCoin.self, from: data) {
                print(jsonModel)
                results = [jsonModel]
            }
            
        } catch  {
            print("Failed to decode JSON: \(error.localizedDescription)")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
