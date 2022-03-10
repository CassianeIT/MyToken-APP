//
//  DemoClipApp.swift
//  DemoClip
//
//  Created by Curitiba on 08/03/22.
//

import SwiftUI

@main
struct DemoClipApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: CoinViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
