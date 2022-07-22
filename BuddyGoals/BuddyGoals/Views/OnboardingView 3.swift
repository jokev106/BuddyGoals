//
//  OnboardingView.swift
//  BuddyGoals
//
//  Created by Jonathan Kevin on 12/07/22.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        
        VStack{
            //Onboarding TITLE
            Text(" Welcome to\nBuddy Goals!")
                .fontWeight(.bold)
                .lineSpacing(10)
                .font(.system(size: 50).bold())
                .foregroundColor(primary900)
            
            Spacer()
                .frame( height: 60)
            
            //Pict and text 1
            HStack{
                Image("Onboarding1")
                    .resizable()
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .frame(width: 120, height: 120)
                VStack{
                    Text("Achieve Goals with your Buddy")
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                        .padding(.bottom, 1.0)
                        .frame(width: 250, alignment: .leading)
                    Text("Invite a friend, colleagues, or significant others as an accountability partner to help you achieve your Goal.")
                        .font(.system(size: 12))
                        .padding(.horizontal, 1.0)
                        .frame(width: 250, alignment: .leading)
                }
            }
            Spacer()
                .frame( height: 20)
            //pict and text 2
            HStack{
                Image("Onboarding2")
                    .resizable()
                    .padding(.all)
                    .frame(width: 115, height: 115)
                VStack{
                    Text("Break down Goals")
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                        .padding(.bottom, 1.0)
                        .frame(width: 250, alignment: .leading)
                    Text("Small bites, goals are easier to do if broken down to Plans and Actions.")
                        .font(.system(size: 12))
                        .padding(.horizontal, 1.0)
                        .frame(width: 250, alignment: .leading)
                }
            }
            Spacer()
                .frame( height: 20)
            //pict and text 3
            HStack{
                Image("development")
                    .resizable()
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .frame(width: 110, height: 110)
                VStack{
                    Text("Improve everyday")
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                        .padding(.bottom, 1.0)
                        .frame(width: 250, alignment: .leading)
                    Text("Improve yourself continuously every day and be the best version of yourself.")
                        .font(.system(size: 12))
                        .padding(.horizontal, 1.0)
                        .frame(width: 250, alignment: .leading)
                        
                }
            }
            Spacer()
                .frame( height: 90)
            
            Button {
                
            } label: {
                Text("Get Started")
                    .fontWeight(.bold)
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(primary900)
                    .foregroundColor(.white)
                    .cornerRadius(16)
                    .padding(.horizontal, 16)
            }

        }
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
