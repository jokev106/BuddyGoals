//
//  TabbarView.swift
//  BuddyGoals
//
//  Created by I Gede Bagus Wirawan on 28/06/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        
        //Main Tabbar
        TabView {
            CompanionView()
                .tabItem{
                    Label("Companion", systemImage: "person.3.fill")
                }
            
            GoalView()
                .tabItem{
                    Label("Goal", systemImage: "checkmark.square.fill")
                }

            ProgressView()
                .tabItem{
                    Label("Progress", systemImage: "calendar")
                }
        }.accentColor(primary900)
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
