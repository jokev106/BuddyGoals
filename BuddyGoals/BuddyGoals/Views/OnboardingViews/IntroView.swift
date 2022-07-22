//
//  OnboardingView.swift
//  BuddyGoals
//
//  Created by Jonathan Kevin on 12/07/22.
//

import SwiftUI

struct IntroView: View {
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject var gvm : GoalViewModel
    
    
    var body: some View {
        
        
        ZStack{
            if currentUserSignedIn {
                MainView()
            }else{
                OnboardingView()
            }
        }.onAppear() {
            gvm.setup(context: viewContext)
        }
    }
}

