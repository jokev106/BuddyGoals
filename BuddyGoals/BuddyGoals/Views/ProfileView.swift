//
//  RankView.swift
//  BuddyGoals
//
//  Created by I Gede Bagus Wirawan on 28/06/22.
//

import SwiftUI

struct ProfileView: View {
    //    @Environment(\.dismiss) var dismissSheetView
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
    @State private var milestoneTitle:  String = ""
    @State private var startDatePicker = Date()
    
    @ObservedObject var vm : ProfileViewModel = ProfileViewModel()
    @EnvironmentObject var gvm : GoalViewModel
    
    //variable for form
//    @State private var currentGoal : String = ""
//    @State private var scheduleStart = Date()
    @State private var tapEditProfile: Bool = false
    
    //variable for form
    // @State private var currentName : String = ""
    // @State private var currentGoal : String = ""
    // @State private var scheduleStart = Date()
    // @State private var scheduleEnd = Date()

    
    
    var body: some View {
        GeometryReader{ geo in
            
            VStack{
                NavigationView{
                    
                    VStack {
                        
                        //Form
                        if !tapEditProfile {
                            formProfile
                        } else if tapEditProfile {
                            formEditProfile
                        }
                        
                        
                    }//VStack
                    //navbar Setting
                    .navigationBarTitle(
                        Text("Profile").bold(),
                        displayMode: .inline)
                    .navigationBarItems(
                    leading:
                        Button(action: {
                            if !tapEditProfile {
                                presentationMode.wrappedValue.dismiss()
                            } else {
                                tapEditProfile = false
                            }
                        }) {
                            if !tapEditProfile {
                                Text("Back").bold()
                            } else {
                                Text("Cancel").bold()
                            }
                        },
                    
                    trailing:
                        Button(action: {
                            //Do Action
                            if !tapEditProfile {
                                tapEditProfile = true
                                //Action
                                
                            } else {
                                //Action
                                
                            }
                            
                        }) {
                            
                            if !tapEditProfile {
                                Text("Edit").bold()
                            } else {
                                Text("Done").bold()
                            }
                            
                        }
                    )
                    .foregroundColor(Color.white)
                    
                }//navigationView
                .navigationAppearance(backgroundColor: UIColor(primary900), foregroundColor: .white, hideSeperator: true)
            }//Vstack Line 23
        }//geometryReader
        .onAppear() {
            vm.setup(context: gvm.context!, userID: gvm.user.first!.id!)
        }
    }//bodyView
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

extension ProfileView {
    
    // Form Profile
    var formProfile: some View {
        
        VStack {
            Image("Gusde-Emot")
                .resizable()
                .clipShape(Circle())
                .frame(width: 125, height: 125, alignment: .center)
                .padding()
                
            //Continue Profile
            Text("Giga Chadson")//Name
                .foregroundColor(.black)
                .font(.system(size: 25))
                .multilineTextAlignment(.center)
            
            HStack {
                Text("gghch")
                    .foregroundColor(whiteDark)
                Image(systemName: "doc.on.doc")
                    .foregroundColor(whiteDark)
            }
            
            Form {
                
                //Form
                Section (header: Text("Current Goal")
                            .foregroundColor(Color.blue)
                            .bold()
                ){
                    TextField("Set your goal", text: $currentGoal)
                        .padding(.all, 7.0)
                        .foregroundColor(Color.black)
                    //                            .padding(.horizontal)
                }
                
                Section (header: Text("Scheduling")
                            .foregroundColor(Color.blue)
                            .bold()
                ){
                    DatePicker("Start Date", selection: $scheduleStart, in: Date()..., displayedComponents: .date)
                        .padding(.leading, 5.0)
                        .foregroundColor(Color.black)
                    DatePicker("Duration", selection: $scheduleEnd, in: Date()..., displayedComponents: .date)
                        .padding(.leading, 5.0)
                        .foregroundColor(Color.black)
                }
                
                Section {
                    HStack {
                        Spacer()
                        Button(action: {
                            //action
                        }, label: {
                            Text("End Goal")
                                .foregroundColor(.red)
                                .bold()
                                .multilineTextAlignment(.center)
                        })
                        Spacer()
                        //End Form
                    }
                }
                .listRowBackground(white)
                
                
            } //Form
        }.background(Color.init(uiColor: .systemGray6)) //VStack
        
    } // Form Profile
    
    // Form Edit Profile
    var formEditProfile: some View {
        VStack {
            
            Button(action: {
                //Action
                
            }, label: {
                ZStack {
                    
                    Image("Gusde-Emot")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 125, height: 125, alignment: .center)
                        .foregroundColor(.red)
                        .padding()
                    
                    Circle()
                        .foregroundColor(Color.black.opacity(0.6))
                        .frame(width: 125, height: 125, alignment: .center)
                        
                    
                    Text("Change Image")
                        .font(.caption)
                    
                    
                    
                    
                }
            }) //Button
            
            Form {
                
                //Form
                Section (header: Text("Display Name")
                            .foregroundColor(Color.blue)
                            .bold()
                ){
                    TextField("Set your goal", text: $currentName)
                        .padding(.all, 7.0)
                        .foregroundColor(Color.black)
                    //                            .padding(.horizontal)
                }
                
                Section (header: Text("Current Goal")
                            .foregroundColor(Color.blue)
                            .bold()
                ){
                    TextField("Set your goal", text: $currentGoal)
                        .padding(.all, 7.0)
                        .foregroundColor(Color.black)
                    //                            .padding(.horizontal)
                }
                
                Section (header: Text("Scheduling")
                            .foregroundColor(Color.blue)
                            .bold()
                ){
                    DatePicker("Start Date", selection: $scheduleStart, in: Date()..., displayedComponents: .date)
                        .padding(.leading, 5.0)
                        .foregroundColor(Color.black)
                    DatePicker("Duration", selection: $scheduleEnd, in: Date()..., displayedComponents: .date)
                        .padding(.leading, 5.0)
                        .foregroundColor(Color.black)
                }
                
                
            } //Form
        }.background(Color.init(uiColor: .systemGray6)) //VStack
    } // Form Edit Profile
    
}
