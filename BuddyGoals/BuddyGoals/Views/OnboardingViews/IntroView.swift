//
//  OnboardingView.swift
//  BuddyGoals
//
//  Created by Jonathan Kevin on 12/07/22.
//

import SwiftUI

struct IntroView: View {
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    
    var body: some View {
        
        
        ZStack{
            if currentUserSignedIn {
                MainView()
            }else{
                OnboardingView()
            }
        }
    }
}

