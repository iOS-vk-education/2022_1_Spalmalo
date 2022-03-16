//
//  calorizoidApp.swift
//  calorizoid
//
//  Created by Jasur Tursunov on 16.03.2022.
//

import SwiftUI

@main
struct calorizoidApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
