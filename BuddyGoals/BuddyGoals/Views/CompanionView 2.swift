//
//  CompanionView.swift
//  BuddyGoals
//
//  Created by I Gede Bagus Wirawan on 28/06/22.
//

import SwiftUI

struct CompanionView: View {
    var body: some View {
        
        VStack {
            
            Image("development")
                .resizable()
                .frame(width: 300, height: 300)
            
            Text("Coming Soon")
                .bold()
                .font(.system(size: 20))
                .foregroundColor(primaryDark)
            
        }
        
    }
}

struct CompanionView_Previews: PreviewProvider {
    static var previews: some View {
        CompanionView()
    }
}
