//
//  LoginView.swift
//  BuddyGoals
//
//  Created by Jonathan Kevin on 13/07/22.
//

import SwiftUI

struct LoginView: View {
    
    @State private var emailLogin:  String = ""
    @State private var passwordLogin:  String = ""
    
    var body: some View {
        GeometryReader { geo in
            
            VStack{
                Spacer()
                    .frame(height: 30)
                
                //Chevron back to Register page
                Image(systemName: "chevron.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.leading)
                    .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                    .foregroundColor(Color.black)
                Spacer()
                    .frame(height: 50)
                
                //Title login page
                Text("Log in")
                    .font(.system(size: 35).bold())
                    .padding(.leading, 26.0)
                    .foregroundColor(primary900)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                    .frame(height: 40)
                Group{
                    //Text field for login
                    TextField("Email", text: $emailLogin)
                        .padding()
                        .frame(width: 350, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 5).fill(Color.white))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1)
                        )
                        .foregroundColor(.black)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    TextField("Password", text: $passwordLogin)
                        .padding()
                        .frame(width: 350, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 5).fill(Color.white))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1)
                        )
                        .foregroundColor(.black)
                }
                
                Spacer()
                    .frame(height: 100)
                
                Group{
                    //Button for sign in
                    Button(action: {}) {
                        Text("Sign In")
                            .fontWeight(.bold)
                                .padding(16)
                        }
                    .frame(width: 350, alignment: .center)
                    .background(primary900)
                    .foregroundColor(.white)
                    .cornerRadius(18)
                    
                }
                
            }
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
