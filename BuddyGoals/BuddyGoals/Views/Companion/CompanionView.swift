//
//  CompanionView.swift
//  BuddyGoals
//
//  Created by I Gede Bagus Wirawan on 28/06/22.
//

import SwiftUI

struct CompanionView: View {
    
    let user = "" //example
    @State private var inviteBuddy: Bool = false
    @State private var searchText = ""
    @State private var showBuddyView = false

    var body: some View {
                
        NavigationView {
            
            if user == "" {
                if !inviteBuddy {
                    emptyBuddyView
                } else if inviteBuddy {
                    inviteBuddyView
                }
                
            } else {
                BuddyView()
            }
            
        } //Navigation View
        .navigationAppearance(backgroundColor: UIColor(.red), foregroundColor: .white, hideSeperator: true)
        
    } // var body
}

struct CompanionView_Previews: PreviewProvider {
    static var previews: some View {
        CompanionView()
    }
}

extension CompanionView {
    
    var emptyBuddyView : some View {
        VStack {
            
            Image("Invite-Buddy")
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
            
            Text("Achieve Goals with your Buddy")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.top)
                .frame(width: 200)
            
            Text("Invite a friend, colleague, or significant other as an accountability partner to help you achieve your Goal.")
                .font(.caption2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .padding(.top, 75.0)
                .frame(width: 300)
                .foregroundColor(whiteDark)
            
            Button(action: {
                //Action
                inviteBuddy = true
            }, label: {
                Text("Invite Buddy")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.white)
                    .background(primary900)
                    .cornerRadius(15)
            })
            .padding(.top, 5.0)
            .frame(width: .infinity)
            
        }
        .navigationTitle("Buddy")
        .navigationBarTitleDisplayMode(.inline)
    } //empty buddy
    
    var inviteBuddyView: some View {
        
        VStack {
            
            Text("\(searchText)")
                .searchable(text: $searchText)
            
         
            Image("Gusde-Emot")
                .resizable()
                .clipShape(Circle())
                .frame(width: 125, height: 125, alignment: .center)
                .padding()
            
            Text("Buddy's Name")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(width: 200)
            
            Button(action: {
                //Action
                showBuddyView = true
            }, label: {
                Text("Invite")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.white)
                    .background(primary900)
                    .cornerRadius(15)
            })
            .padding(.top, 5.0)
            .frame(width: .infinity)
            //NavigationLink("", destination:  BuddyView(), isActive: $showBuddyView)
               
            
            Spacer()
        }
        .navigationTitle("Buddy")
        .navigationBarTitleDisplayMode(.inline)
        
    } //inviteBuddyView
    
}
