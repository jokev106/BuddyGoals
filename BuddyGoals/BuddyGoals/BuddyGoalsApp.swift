//
//  BuddyGoalsApp.swift
//  BuddyGoals
//
//  Created by Jonathan Kevin on 11/07/22.
//

import SwiftUI

@main
struct BuddyGoalsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
