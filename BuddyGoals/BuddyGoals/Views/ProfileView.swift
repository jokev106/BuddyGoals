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
    @State private var scheduleEnd = Date()

    
    
    var body: some View {
        GeometryReader{ geo in
            
            VStack{
                NavigationView{
                    
                    VStack {
                        
                        Image("Gusde-Emot")
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
                                TextField("Set your goal", text: $vm.currentGoal)
                                    .padding(.all, 7.0)
                                    .foregroundColor(Color.black)
                                //                            .padding(.horizontal)
                            }
                            
                            Section (header: Text("Scheduling")
                                        .foregroundColor(Color.blue)
                                        .bold()
                            ){
                                DatePicker("Start Date", selection: $vm.scheduleStart, in: Date()..., displayedComponents: .date)
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
                        
                        
                        
                        
                    }//VStack
                    //navbar Setting
                    .navigationBarTitle(
                        Text("Profile").bold(),
                        displayMode: .inline)
                    .navigationBarItems(
                    leading:
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Back").bold()
                        },
                    
                    trailing:
                        Button(action: {
                            //Do Action
                            //presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Edit").bold()
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
