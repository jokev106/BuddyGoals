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
    
    @StateObject var vm : ProfileViewModel = ProfileViewModel()
    @EnvironmentObject var gvm : GoalViewModel
    
    //variable for form
//    @State private var currentGoal : String = ""
//    @State private var scheduleStart = Date()
    @State private var tapEditProfile: Bool = false
    
    //variable for form
    // @State private var currentName : String = ""
    // @State private var currentGoal : String = ""
    // @State private var scheduleStart = Date()
    //@State private var scheduleEnd = Date()

    
    //var for submission image picker
    @State var changeSubmissionImage = false
    @State var openCameraSheet = false
    
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
                                vm.fillProperties()
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
                                vm.update()
                                tapEditProfile = false
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
        .onDisappear() {
            gvm.getUser()
            gvm.calculateRemainingDays()
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
            Image(uiImage: vm.imageSelected)
                .resizable()
                .clipShape(Circle())
                .frame(width: 125, height: 125, alignment: .center)
                .padding()
                
            //Continue Profile
            Text(vm.name)//Name
                .foregroundColor(.black)
                .font(.system(size: 25))
                .multilineTextAlignment(.center)
            
            HStack {
                Text(vm.user?.wrappedId ?? "No ID Attached")
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
                    
                    Text("\(vm.currentGoal)")
                        .foregroundColor(Color.black)
                    
                }
                
                Section (header: Text("Scheduling")
                            .foregroundColor(Color.blue)
                            .bold()
                ){
                    HStack {
                        Text("Start Date")
                        Spacer()
                        Text("\(vm.scheduleStart.formatted(.dateTime.day().month().year()))")
                    }
                    .padding(.leading, 5.0)
                    .foregroundColor(Color.black)
                    
                    HStack {
                        Text("Duration")
                        Spacer()
                        Text("\(vm.duration) Weeks")
                    }
                    .padding(.leading, 5.0)
                    .foregroundColor(Color.black)
                    
                }
                
                Section {
                    HStack {
                        Spacer()
                        Button(action: {
                            //action
                            vm.finishGoal()
                            vm.fillProperties()
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
                changeSubmissionImage = true
                openCameraSheet = true
            }, label: {
                ZStack {
                    
                    Image(uiImage: vm.imageSelected)
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
            .sheet(isPresented: $openCameraSheet) {
                SubmissionPicker(selectedImage: $vm.imageSelected, sourceType: .photoLibrary)
            }
            Form {
                
                //Form
                Section (header: Text("Display Name")
                            .foregroundColor(Color.blue)
                            .bold()
                ){
                    TextField("Set your goal", text: $vm.name)
                        .padding(.all, 7.0)
                        .foregroundColor(Color.black)
                    //                            .padding(.horizontal)
                }
                
                Section (header: Text("Current Goal")
                            .foregroundColor(Color.blue)
                            .bold()
                ){
                    TextField("Set your goal", text: $vm.currentGoal)
                        .padding(.all, 7.0)
                        .foregroundColor(Color.black)
                    //                            .padding(.horizontal)
                }
                
                Section (header: Text("Scheduling")
                            .foregroundColor(Color.blue)
                            .bold()
                ){
                    DatePicker("Start Date", selection: $vm.scheduleStart, in: vm.scheduleStart..., displayedComponents: .date)
                        .padding(.leading, 5.0)
                        .foregroundColor(Color.black)
                    
                    HStack {
                        Text("Duration")
                            .padding(.trailing)
                        Spacer()
                        TextField("Set your duration", value: $vm.duration, formatter: NumberFormatter())
                        Text(" Weeks")
                    }
                    .padding(.leading, 5.0)
                    .foregroundColor(Color.black)
                    
                }
                
                
            } //Form
        }.background(Color.init(uiColor: .systemGray6)) //VStack
    } // Form Edit Profile
    
}
