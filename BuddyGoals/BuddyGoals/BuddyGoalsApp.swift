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
    @StateObject var activityToday = Dailies()

    var body: some Scene {
        WindowGroup {
            IntroView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(activityToday)
        }
    }
}
