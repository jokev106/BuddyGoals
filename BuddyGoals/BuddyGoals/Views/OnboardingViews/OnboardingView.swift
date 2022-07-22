//
//  OnboardingView.swift
//  BuddyGoals
//
//  Created by Jonathan Kevin on 20/07/22.
//

import SwiftUI

struct OnboardingView: View {
    
    @ObservedObject var vm = OnboardingViewModel()
    @EnvironmentObject var gvm : GoalViewModel
    /*
     Onboarding State Section
     0 - Welcome Section
     1 - Register Section
     2 - 3 Step intro Section
     3 - Add Goal Section
     4 - Add Plan Section
     5 - Add Action Section
     6 - Appreciation Section
     */
    @State var onboardingState: Int = 0
    
    //Animation moveing section
//    let transitionSection: AnyTransition = .asymmetric(
//        insertion: .move(edge: .leading),
//        removal: .move(edge: .leading))
    
    //Alert
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    //Register var
    @State private var nameRegister:  String = ""
    @State private var idRegister:  String = ""
    
    //Set onboarding goal var
    @State private var onboardingGoal: String = ""
    @State private var onboardingPlan: String = ""
    @State private var onboardingAction: String = ""
    
    
    //App Storage
    @AppStorage("onboardingGoal") var currentUserGoal: String?
    @AppStorage("onboardingPlan") var currentUserPlan: String?
    @AppStorage("onboardingAction") var currentUserAction: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    var body: some View {
        ZStack{
            //Content
            ZStack{
                switch onboardingState {
                case 0:
                    welcomeSection
//                        .transition(transitionSection)
                case 1:
                    registerSection
//                        .transition(transitionSection)
                case 2:
                    stepIntroSection
//                        .transition(transitionSection)
                case 3:
                    addGoalSection
//                        .transition(transitionSection)
                case 4:
                    addPlanSection
//                        .transition(transitionSection)
                case 5:
                    addActionSection
//                        .transition(transitionSection)
                case 6:
                    appreciationSection
//                        .transition(transitionSection)
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
        .alert(isPresented: $showAlert) {
            return Alert(title: Text(alertTitle))
        }.onAppear() {
            vm.setup(context: gvm.context!)
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
            if onboardingState == 1 {
            } else if onboardingState == 6 {
//                vm.addNewUser(name: nameRegister, username: idRegister)
                vm.addNewGoal(title: onboardingGoal)
                vm.addNewPlan(title: onboardingPlan)
                vm.addNewAction(title: onboardingAction)
            }
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
                Image("Onboarding3")
                    .resizable()
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .frame(width: 110, height: 110)
                VStack{
                    Text("Hold Yourself Accountable")
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                        .padding(.bottom, 1.0)
                        .frame(width: 250, alignment: .leading)
                    Text("Submit your actions by taking a picture of your task and Rock On!")
                        .font(.system(size: 12))
                        .padding(.horizontal, 1.0)
                        .frame(width: 250, alignment: .leading)
                    
                }
            }
            Spacer()
                .frame( height: 120)
            
        }
    }
    
    private var registerSection: some View {
        VStack{
            Spacer()
                .frame(height: 20)
            //Navigation item(chevron left, current page, skip)
            Group{
                HStack{
                    Image(systemName: "chevron.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.leading)
                        .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                        .foregroundColor(primary900)
                        .onTapGesture {
                            //Code go back to Onboarding
                            previousButtonPressed()
                        }
                    Spacer()
                    ForEach(0..<6){ state in
                        if state == 0{
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(primary900)
                        }else{
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                        .frame(width: 100)
                    Button {
                        //Skip func
                        skipButtonPresssed()
                    } label: {
                        Text("Skip")
                    }
                    Spacer()
                        .frame(width: 10)

                }
            }
            Spacer()
                .frame(height: 35)
            
            //Title login page
            Text("Hi There!,")
                .font(.system(size: 35).bold())
                .padding(.leading, 26.0)
                .foregroundColor(primary900)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Let's get to know \nbetter!")
                .font(.system(size: 35).bold())
                .padding(.leading, 26.0)
                .foregroundColor(primary900)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
                .frame(height: 50)
            Group{
                //Text field NAME
                Text("FULL NAME")
                    .foregroundColor(primary900)
                    .fontWeight(.bold)
                    .font(.system(size: 12))
                    .padding(.horizontal, 1.0)
                    .frame(width: 320, alignment: .leading)
                TextField("Giga Chad", text: $nameRegister)
                    .padding()
                    .frame(width: 350, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 5).fill(Color.white))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                    )
                    .foregroundColor(.gray)
                
                Spacer()
                    .frame(height: 30)
                //Text field ID
                Text("BUDDY ID")
                    .foregroundColor(primary900)
                    .fontWeight(.bold)
                    .font(.system(size: 12))
                    .padding(.horizontal, 1.0)
                    .frame(width: 320, alignment: .leading)
                TextField("ggch4d", text: $idRegister)
                    .padding()
                    .frame(width: 350, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 5).fill(Color.white))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                    )
                    .foregroundColor(.gray
                    )
                Text("Make your own Buddy ID (Max. 15 character).\n   Once your ID is set, it cannot be changed.")
                    .foregroundColor(.gray)
                    .fontWeight(.bold)
                    .font(.system(size: 10))
                    .padding(.horizontal, 1.0)
                    .frame(width: 320, alignment: .center)
            }
            
            Spacer()
            //Button for register
            /*
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

         //Login account button
         Button(action: {
             //Action
         }) {
             Text("Already have an account? Sign In")
                 .foregroundColor(.white)
                 .font(.system(size: 14))
         }
             */
            
        }
        //        .background(primary900)
    }
    
    private var stepIntroSection: some View {
        VStack{
            Spacer()
                .frame(height: 20)
            //Navigation item(chevron left, current page, skip)
            Group{
                HStack{
                    Image(systemName: "chevron.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.leading)
                        .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                        .foregroundColor(primary900)
                        .onTapGesture {
                            //Code go back to Onboarding
                            previousButtonPressed()
                        }
                    Spacer()
                    ForEach(0..<6){ state in
                        if state == 1{
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(primary900)
                        }else{
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                        .frame(width: 100)
                    Button {
                        //Skip func
                        skipButtonPresssed()
                    } label: {
                        Text("Skip")
                    }
                    Spacer()
                        .frame(width: 10)

                }
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
            //Navigation item(chevron left, current page, skip)
            Group{
                HStack{
                    Image(systemName: "chevron.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.leading)
                        .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                        .foregroundColor(primary900)
                        .onTapGesture {
                            //Code go back to Onboarding
                            previousButtonPressed()
                        }
                    Spacer()
                    ForEach(0..<6){ state in
                        if state == 2{
                            Circle()
                                .frame(width: 10, height: 10)                                .foregroundColor(primary900)
                        }else{
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                        .frame(width: 100)
                    Button {
                        //Skip func
                        skipButtonPresssed()
                    } label: {
                        Text("Skip")
                    }
                    Spacer()
                        .frame(width: 10)

                }
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
                .frame(height: 150)
        }
    }
    
    private var addPlanSection: some View {
        VStack{
            Group{
                Spacer()
                    .frame(height: 20)
                //Navigation item(chevron left, current page, skip)
                Group{
                    HStack{
                        Image(systemName: "chevron.left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.leading)
                            .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                            .foregroundColor(primary900)
                            .onTapGesture {
                                //Code go back to Onboarding
                                previousButtonPressed()
                            }
                        Spacer()
                        ForEach(0..<6){ state in
                            if state == 3{
                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(primary900)
                            }else{
                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                            .frame(width: 100)
                        Button {
                            //Skip func
                            skipButtonPresssed()
                        } label: {
                            Text("Skip")
                        }
                        Spacer()
                            .frame(width: 10)

                    }
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
            }
            
            Group{
                Spacer()
                    .frame(height: 35)
                Text("GOAL")
                    .foregroundColor(primary900)
                    .font(.system(size: 15))
                    .padding(.horizontal, 1.0)
                    .frame(width: 320, alignment: .leading)
                Text(currentUserGoal ?? "Lose Weight 20 Kg")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .padding(.horizontal, 1.0)
                    .frame(width: 320, alignment: .leading)
            }
            
            Spacer()
            
            Group{
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
            }
            
            Spacer()
                .frame(height: 150)
        }
    }
    
    private var addActionSection: some View {
        VStack{
            Spacer()
                .frame(height: 20)
            //Navigation item(chevron left, current page, skip)
            Group{
                HStack{
                    Image(systemName: "chevron.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.leading)
                        .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                        .foregroundColor(primary900)
                        .onTapGesture {
                            //Code go back to Onboarding
                            previousButtonPressed()
                        }
                    Spacer()
                    ForEach(0..<6){ state in
                        if state == 4{
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(primary900)
                        }else{
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                        .frame(width: 100)
                    Button {
                        //Skip func
                        skipButtonPresssed()
                    } label: {
                        Text("Skip")
                    }
                    Spacer()
                        .frame(width: 10)

                }
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
                .frame(height: 15)
            Text("What real Action you can do \ninside of this Plan? Make it detailed!")
                .foregroundColor(.gray)
                .font(.system(size: 18))
                .padding(.horizontal, 1.0)
                .frame(width: 320, height: 100, alignment: .leading)
            
            Group{
                Spacer()
                    .frame(height: 35)
                Text("GOAL")
                    .foregroundColor(primary900)
                    .font(.system(size: 15))
                    .padding(.horizontal, 1.0)
                    .frame(width: 320, alignment: .leading)
                Text(currentUserGoal ?? "Lose Weight 20 Kg")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .padding(.horizontal, 1.0)
                    .frame(width: 320, alignment: .leading)
                Spacer()
                    .frame(height: 10)
                Text("PLAN")
                    .foregroundColor(primary900)
                    .font(.system(size: 15))
                    .padding(.horizontal, 1.0)
                    .frame(width: 320, alignment: .leading)
                Text(currentUserPlan ?? "Exercises")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .padding(.horizontal, 1.0)
                    .frame(width: 320, alignment: .leading)
            }
            Spacer()
            Group{
                Text("ACTION")
                    .foregroundColor(primary900)
                    .font(.system(size: 15))
                    .padding(.horizontal, 1.0)
                    .frame(width: 320, alignment: .leading)
                
                TextField("Ex. Exercises", text: $onboardingAction)
                    .padding()
                    .frame(width: 350, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 5).fill(Color.white))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                    )
                    .foregroundColor(primary900)
                
                Spacer()
                    .frame(height: 150)
            }
        }
    }
    
    private var appreciationSection: some View {
        VStack{
            Spacer()
                .frame(height: 20)
            //Navigation item(chevron left, current page, skip)
            Group{
                HStack{
                    Image(systemName: "chevron.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.leading)
                        .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                        .foregroundColor(primary900)
                        .onTapGesture {
                            //Code go back to Onboarding
                            previousButtonPressed()
                        }
                    Spacer()
                    ForEach(0..<6){ state in
                        if state == 5{
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(primary900)
                        }else{
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                        .frame(width: 100)
                    Button {
                        //Skip func
                        skipButtonPresssed()
                    } label: {
                        Text("Skip")
                    }
                    Spacer()
                        .frame(width: 10)

                }
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
                    Text(onboardingGoal )
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
                    Text(onboardingPlan )
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
                    Text(onboardingAction )
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
    
    func previousButtonPressed(){
        
        withAnimation(.spring()) {
            onboardingState -= 1
        }

    }
    
    func nextButtonPressed(){
        
        //Check input data
        switch onboardingState {
        case 1:
            guard nameRegister.count > 1 else {
                showAlert(title: "Email and Password can't be empty")
                return
            }
            guard idRegister.count > 1 else {
                showAlert(title: "Email and Password can't be empty")
                return
            }
            guard idRegister.count <= 15 else {
                showAlert(title: "Buddy ID Max. 15 character and can't be changed")
                return
            }
            guard nameRegister.count <= 15 else {
                showAlert(title: "")
                return
            }
            vm.addNewUser(name: nameRegister, username: idRegister)
        case 3:
            guard onboardingGoal.count > 1 else {
                showAlert(title: "You have to set your Goal first!")
                return
            }
        case 4:
            guard onboardingPlan.count > 1 else {
                showAlert(title: "You have to set your Plan!")
                return
            }
        case 5:
            guard onboardingAction.count > 1 else {
                showAlert(title: "You have to set your Action")
                return
            }
        default:
            break
            
        }
        
        //GOTO NEXT SECTION
        if onboardingState == 6 {
            //Sign in
            signIn()
        }else{
            withAnimation(.spring()) {
                onboardingState += 1
                passData()
            }
        }
        
    }
    
    func skipButtonPresssed(){
        withAnimation(.spring()){
            vm.addEmptyUser()
            currentUserSignedIn = true
        }
    }
    
    func signIn(){
        currentUserGoal = onboardingGoal
        currentUserPlan = onboardingPlan
        currentUserAction = onboardingAction
        withAnimation(.spring()){
        currentUserSignedIn = true
        }
    }
    
    func passData(){
        currentUserGoal = onboardingGoal
        currentUserPlan = onboardingPlan
        currentUserAction = onboardingAction
    }
    
    func showAlert(title: String){
        alertTitle = title
        showAlert.toggle()
    }
    
}
