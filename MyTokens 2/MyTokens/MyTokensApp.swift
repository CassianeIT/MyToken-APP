//
//  MyTokensApp.swift
//  MyTokens
//
//  Created by Curitiba on 16/02/22.
//

import SwiftUI

@main
struct MyTokensApp: App {
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            ListCoins(viewModel: CoinViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }        
    }
}

