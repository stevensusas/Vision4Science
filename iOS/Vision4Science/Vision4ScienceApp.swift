//
//  Vision4ScienceApp.swift
//  Vision4Science
//
//  Created by Steven Su on 2/26/24.
//

import SwiftUI
import SwiftData
import Firebase

@main
struct Vision4ScienceApp: App {
    init() {
            FirebaseApp.configure()
        }
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            LoginPage()
        }
        .modelContainer(sharedModelContainer)
    }
}
