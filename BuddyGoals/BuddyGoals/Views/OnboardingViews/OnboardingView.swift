//
//  OnboardingView.swift
//  BuddyGoals
//
//  Created by Jonathan Kevin on 20/07/22.
//

import SwiftUI

struct OnboardingView: View {
    
    /*
     0 - Welcome Section
     1 - Register Section
     2 - 3 Step intro
     3 - Add Goal
     4 - Add Plan
     5 - Add Action
     6 - Appreciation
     */
    @State var onboardingState: Int = 0
    
    //Register var
    @State private var emailRegister:  String = ""
    @State private var passwordRegister:  String = ""
    
    //Set onboarding goal var
    @State private var onboardingGoal: String = ""
    @State private var onboardingPlan: String = ""
    
    var body: some View {
        ZStack{
            //Content
            ZStack{
                switch onboardingState {
                case 0:
                    welcomeSection
                case 1:
                    registerSection
                case 2:
                    stepIntroSection
                case 3:
                    addGoalSection
                case 4:
                    addPlanSection
                case 5:
                    addActionSection
                case 6:
                    appreciationSection
                default:
                    Rectangle()
                        .foregroundColor(.black)
                }
            }
            
            //Button
            VStack{
                Spacer()
                bottomButton
            }.padding(30)
        }
    }
    
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

//MARK: COMPONENTS
extension OnboardingView {
    
    private var bottomButton: some View {
        Text(onboardingState == 0 ? "Get Started" :
                onboardingState == 1 ? "Sign Up" :
                onboardingState == 6 ? "Finish" :
                "Continue"
        )
        .fontWeight(.bold)
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .background(primary900)
        .foregroundColor(.white)
        .cornerRadius(10)
        .onTapGesture {
            nextButtonPressed()
        }
    }
    
    private var welcomeSection: some View {
        VStack{
            //Onboarding TITLE
            Text(" Welcome to\nBuddy Goals!")
                .fontWeight(.bold)
                .lineSpacing(10)
                .font(.system(size: 50).bold())
                .foregroundColor(primary900)
            
            Spacer()
                .frame( height: 70)
            
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
                .frame( height: 120)
            
        }.padding(20)
    }
    
    private var registerSection: some View {
        VStack{
            Spacer()
                .frame(height: 60)
            //Chevron back to onboarding page
            Image(systemName: "chevron.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.leading)
                .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                .foregroundColor(primary900)
                .onTapGesture {
                    //Code go back to Onboarding
                }
            Spacer()
                .frame(height: 50)
            
            //Title login page
            Text("Hi There!")
                .font(.system(size: 35).bold())
                .padding(.leading, 26.0)
                .foregroundColor(primary900)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Let's get better!")
                .font(.system(size: 35).bold())
                .padding(.leading, 26.0)
                .foregroundColor(primary900)
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
                    .foregroundColor(primary900)
                
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
                    .foregroundColor(primary900)
            }
            
            Spacer()
            //                .frame(height: 220)
            
            //            Group{
            //                //Button for sign in
            //                Button(action: {}) {
            //                    Text("Sign Up")
            //                        .fontWeight(.bold)
            //                        .padding(16)
            //                }
            //                .frame(width: 350, alignment: .center)
            //                .background(.white)
            //                .foregroundColor(primary900)
            //                .cornerRadius(18)
            //
            //                Spacer()
            //                    .frame(height: 5)
            //                HStack{
            //                    Rectangle()
            //                        .frame(width: 90, height: 1)
            //                        .background(.white)
            //                        .border(.white)
            //                    Text("Or")
            //                        .font(.system(size: 15))
            //                        .foregroundColor(.white)
            //                    Rectangle()
            //                        .frame(width: 90, height: 1)
            //                        .background(.white)
            //                        .border(.white
            //                        )
            //                }
            //                //Button for sign in via APPLE ACCOUNT
            //                Button(action: {
            //                    //Action
            //                }) {
            //                    Image(systemName: "applelogo")
            //                    Text("Sign Up with Apple")
            //                        .fontWeight(.bold)
            //                        .padding(16)
            //                }
            //                .frame(width: 350, alignment: .center)
            //                .background(.black)
            //                .foregroundColor(.white)
            //                .cornerRadius(18)
            //            }
            
            //            //Login account button
            //            Button(action: {
            //                //Action
            //            }) {
            //                Text("Already have an account? Sign In")
            //                    .foregroundColor(.white)
            //                    .font(.system(size: 14))
            //            }
            
        }
        //        .background(primary900)
    }
    
    private var stepIntroSection: some View {
        VStack{
            Spacer()
                .frame(height: 20)
            //Chevron back to previous page
            Image(systemName: "chevron.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.leading)
                .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                .foregroundColor(primary900)
                .onTapGesture {
                    //Code go back to Onboarding
                }
            Spacer()
                .frame(height: 30)
            //
            Text("3 Step on breaking down Goals")
                .font(.system(size: 35).bold())
                .padding(.leading, 26.0)
                .foregroundColor(primary900)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
                .frame(height: 30)
            Text("See how you can break your big Goal into smaller chunks to make it easier to achieve.")
                .foregroundColor(.gray)
                .font(.system(size: 18))
                .padding(.horizontal, 1.0)
                .frame(width: 300, alignment: .center)
            Spacer()
        }
    }
    
    private var addGoalSection: some View {
        VStack{
            Spacer()
                .frame(height: 20)
            //Chevron back to previous page
            Image(systemName: "chevron.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.leading)
                .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                .foregroundColor(primary900)
                .onTapGesture {
                    //Code go back to Onboarding
                }
            Spacer()
                .frame(height: 30)
            //Title
            Text("1. What's your current Goal?")
                .font(.system(size: 35).bold())
                .padding(.leading, 26.0)
                .foregroundColor(primary900)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
                .frame(height: 30)
            Text("You can be as broad as you can with your goal.")
                .foregroundColor(.gray)
                .font(.system(size: 18))
                .padding(.horizontal, 1.0)
                .frame(width: 320, alignment: .leading)
            
            Spacer()
                .frame(height: 30)
            
            Text("GOAL")
                .foregroundColor(primary900)
                .font(.system(size: 15))
                .padding(.horizontal, 1.0)
                .frame(width: 320, alignment: .leading)
            
            TextField("Ex. Lose weight 20 Kg", text: $onboardingGoal)
                .padding()
                .frame(width: 350, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 5).fill(Color.white))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                )
                .foregroundColor(primary900)
            
            Spacer()
        }
    }
    
    private var addPlanSection: some View {
        VStack{
            Spacer()
                .frame(height: 20)
            //Chevron back to previous page
            Image(systemName: "chevron.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.leading)
                .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                .foregroundColor(primary900)
                .onTapGesture {
                    //Code go back to Onboarding
                }
            Spacer()
                .frame(height: 30)
            //Title
            Text("2. Now break your \nGoal into Plans")
                .font(.system(size: 35).bold())
                .padding(.leading, 26.0)
                .foregroundColor(primary900)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
                .frame(height: 30)
            Text("How do you plan on achieving your Goal? Let’s start with 1 Plan.")
                .foregroundColor(.gray)
                .font(.system(size: 18))
                .padding(.horizontal, 1.0)
                .frame(width: 320, alignment: .leading)
            
            Spacer()
                .frame(height: 30)
            
            Text("PLAN")
                .foregroundColor(primary900)
                .font(.system(size: 15))
                .padding(.horizontal, 1.0)
                .frame(width: 320, alignment: .leading)
            
            TextField("Ex. Exercises", text: $onboardingPlan)
                .padding()
                .frame(width: 350, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 5).fill(Color.white))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                )
                .foregroundColor(primary900)
            
            Spacer()
        }
    }
    
    private var addActionSection: some View {
        VStack{
            Spacer()
                .frame(height: 20)
            //Chevron back to previous page
            Image(systemName: "chevron.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.leading)
                .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                .foregroundColor(primary900)
                .onTapGesture {
                    //Code go back to Onboarding
                }
            Spacer()
                .frame(height: 30)
            //Title
            Text("3. Make it Actionable")
                .font(.system(size: 35).bold())
                .padding(.leading, 26.0)
                .foregroundColor(primary900)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
                .frame(height: 30)
            Text("What real Action you can do inside of this Plan? Make it detailed!")
                .foregroundColor(.gray)
                .font(.system(size: 18))
                .padding(.horizontal, 1.0)
                .frame(width: 320, alignment: .leading)
            
            Spacer()
                .frame(height: 30)
            
            Text("ACTION")
                .foregroundColor(primary900)
                .font(.system(size: 15))
                .padding(.horizontal, 1.0)
                .frame(width: 320, alignment: .leading)
            
            TextField("Ex. Exercises", text: $onboardingPlan)
                .padding()
                .frame(width: 350, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 5).fill(Color.white))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                )
                .foregroundColor(primary900)
            
            Spacer()
        }
    }
    
    private var appreciationSection: some View {
        VStack{
            Spacer()
                .frame(height: 20)
            //Chevron back to previous page
            Image(systemName: "chevron.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.leading)
                .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                .foregroundColor(primary900)
                .onTapGesture {
                    //Code go back to Onboarding
                }
            Spacer()
                .frame(height: 30)
            //Title
            Text("Great Job!")
                .font(.system(size: 35).bold())
                .padding(.leading, 26.0)
                .foregroundColor(primary900)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
                .frame(height: 20)
            Text("Here’s how your broken down Goal looks like now.")
                .foregroundColor(.gray)
                .font(.system(size: 18))
                .padding(.horizontal, 1.0)
                .frame(width: 320, alignment: .leading)
            
            Spacer()
                .frame(height: 30)
            Group{
                Group{
                    //Goal
                    Text("Goal")
                        .fontWeight(.bold)
                        .foregroundColor(primary900)
                        .font(.system(size: 20))
                        .padding(.horizontal, 1.0)
                        .frame(width: 320, alignment: .leading)
                    Spacer()
                        .frame(height:5)
                    Text("Lose Weight 20 Kg")
                        .foregroundColor(.black)
                        .font(.system(size: 23))
                        .padding(.horizontal, 1.0)
                        .frame(width: 320, alignment: .leading)
                    Spacer()
                        .frame(height:15)
                }
                
                Group{
                    //Plan
                    Text("Plan")
                        .fontWeight(.bold)
                        .foregroundColor(primary900)
                        .font(.system(size: 20))
                        .padding(.horizontal, 1.0)
                        .frame(width: 320, alignment: .leading)
                    Spacer()
                        .frame(height:5)
                    Text("Exercises")
                        .foregroundColor(.black)
                        .font(.system(size: 23))
                        .padding(.horizontal, 1.0)
                        .frame(width: 320, alignment: .leading)
                    Spacer()
                        .frame(height:15)
                }
                Group{
                    //Action
                    Text("Action")
                        .fontWeight(.bold)
                        .foregroundColor(primary900)
                        .font(.system(size: 20))
                        .padding(.horizontal, 1.0)
                        .frame(width: 320, alignment: .leading)
                    Spacer()
                        .frame(height:5)
                    Text("Push Up 100 times")
                        .foregroundColor(.black)
                        .font(.system(size: 23))
                        .padding(.horizontal, 1.0)
                        .frame(width: 320, alignment: .leading)
                }
            }
            
            Spacer()
        }
    }
}


//MARK: FUNCTIONS
extension OnboardingView {
    
    func nextButtonPressed(){
        
//        if onboardingState == 6 {
            //Sign in
//        }else{
            withAnimation(.spring()) {
                onboardingState += 1
            }
//        }
        
    }
}
