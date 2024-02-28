//
//  gShoppingListApp.swift
//  gShoppingList
//
//  Created by angi1g on 26/02/24.
//

import SwiftUI
import SwiftData

@main
struct gShoppingListApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Product.self,
        ])
        //let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        let modelConfiguration = ModelConfiguration(schema: schema, cloudKitDatabase: .automatic)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ListView()
        }
        .modelContainer(sharedModelContainer)
    }
}
