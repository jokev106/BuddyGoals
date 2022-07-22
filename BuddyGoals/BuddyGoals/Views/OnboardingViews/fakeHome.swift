//
//  fakeHome.swift
//  BuddyGoals
//
//  Created by Jonathan Kevin on 20/07/22.
//

import SwiftUI

struct fakeHome: View {
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    var body: some View {
        
        ZStack{
            Text("Home VIEW PALSUUUU!")
            
            if currentUserSignedIn {
                Text("Profile View")
            }else {
                Text("Onboarding View")
            }
        }
        
    }
}

struct fakeHome_Previews: PreviewProvider {
    static var previews: some View {
        fakeHome()
    }
}
