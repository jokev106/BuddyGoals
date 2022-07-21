//
//  RegisterView.swift
//  BuddyGoals
//
//  Created by Jonathan Kevin on 13/07/22.
//

import SwiftUI

struct RegisterView: View {
    
//    @AppStorage("showOnboarding") var showOnboarding: Bool = true
    
    @State private var emailRegister:  String = ""
    @State private var passwordRegister:  String = ""
    
    var body: some View {
        GeometryReader { geo in
            
            VStack{
                Spacer()
                    .frame(height: 30)
                
                //Chevron back to onboarding page
                Image(systemName: "chevron.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.leading)
                    .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                    .foregroundColor(Color.white)
                    .onTapGesture {
                        //Code go back to Onboarding
                    }
                Spacer()
                    .frame(height: 50)
                
                //Title login page
                Text("Hi There!")
                    .font(.system(size: 35).bold())
                    .padding(.leading, 26.0)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Let's get better!")
                    .font(.system(size: 35).bold())
                    .padding(.leading, 26.0)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                    .frame(height: 50)
                Group{
                    //Text field for login
                    TextField("Email", text: $emailRegister)
                        .padding()
                        .frame(width: 350, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 5).fill(Color.white))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1)
                        )
                        .foregroundColor(.white)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    TextField("Password", text: $passwordRegister)
                        .padding()
                        .frame(width: 350, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 5).fill(Color.white))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1)
                        )
                        .foregroundColor(.white)
                }
                
                Spacer()
                    .frame(height: 220)
                
                Group{
                    //Button for sign in
                    Button(action: {}) {
                        Text("Sign Up")
                            .fontWeight(.bold)
                                .padding(16)
                        }
                    .frame(width: 350, alignment: .center)
                    .background(.white)
                    .foregroundColor(primary900)
                    .cornerRadius(18)
                    
                    Spacer()
                        .frame(height: 5)
                    HStack{
                        Rectangle()
                            .frame(width: 90, height: 1)
                            .background(.white)
                            .border(.white)
                        Text("Or")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                        Rectangle()
                            .frame(width: 90, height: 1)
                            .background(.white)
                            .border(.white
                            )
                    }
                    //Button for sign in via APPLE ACCOUNT
                    Button(action: {
                        //Action
                    }) {
                            Image(systemName: "applelogo")
                        Text("Sign Up with Apple")
                            .fontWeight(.bold)
                                .padding(16)
                        }
                    .frame(width: 350, alignment: .center)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(18)
                }
                
                //Register account button
                Button(action: {
                    //Action
                }) {
                    Text("Already have an account? Sign In")
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                    }
                
            }
            
        }
        .background(primary900)
//        .fullScreenCover(isPresented: $showOnboarding, content: {
//            OnboardingView(showOnboarding: $showOnboarding)
//        })
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
