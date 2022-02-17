//
//  ContentView.swift
//  MyToken-APP
//
//  Created by Curitiba on 16/02/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var results = [DetailCoin]()
    
    var body: some View {
        List(results, id: \.name) { item in
            VStack(alignment: .leading) {
                Text(item.id)
                    .font(.headline)
                Text(item.name)
            }
        }
        .task {
            
        }
    }
    
    func loadData() {
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
