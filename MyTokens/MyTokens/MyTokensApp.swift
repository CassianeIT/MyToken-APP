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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
