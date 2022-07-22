//
//  AddActionView.swift
//  BuddyGoals
//
//  Created by Jonathan Kevin on 24/06/22.
//

import SwiftUI

struct EditActionView: View {
    
    //modal view(presentation) mode
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
//    let initialActionTitle : String
//    let initialStartDate : Date
//    let initialRepeatValue : RepeatAction
    let actionID : UUID
//    let action : CoreDataAction
    
    @ObservedObject var vm : EditActionViewModel
    @EnvironmentObject var gvm : GoalViewModel
    
//    var for form input
    @State private var actionTitle:  String = ""
    @State private var actionCommitment:  String = ""
    @State private var detailsDatePicker = Date()
    @State private var detailsWhere:  String = ""
    @State private var scheduleDatePicker = Date()
    @State private var repeatPicker: String = "Daily"
    
    //var for submission image picker
    @State var changeSubmissionImage = false
    @State var openCameraSheet = false
    @State var imageSelected = UIImage()
    
    let repeatOptions: [String] = [
        "Never", "Daily", "Weekdays", "Weekends", "Weekly", "Biweekly", "Monthly", "Every 3 Months", "Every 6 Months", "Yearly"
    ]
//    var imageDifficulty: [String] = [
//        "dTrivial", "dEasy", "dMedium", "dHard", "dExpert"
//    ]
    
//    //Bool difficulty
//        @State var isTappedDifficultyTrivial = false
//        @State var isTappedDifficultyEasy = false
//        @State var isTappedDifficultyMedium = false
//        @State var isTappedDifficultyHard = false
//        @State var isTappedDifficultyExpert = false
//
//
//    @State var isTappedDifficulty = false
      @State var isTappedDetails = false

    // For Editing Purposes
//    var action: Actionable?
//    var planId: UUID?
    
    
    var body: some View {
        GeometryReader{ geo in
            
            VStack{
                
                NavigationView{
                    Form{
                        
                        //Action title set up section
                        Section (header: Text("Title")
                                    .foregroundColor(Color.blue)
                                    .bold()
                        ){
                            TextField("Ex: Morning Run", text: $vm.actionTitle)
                                .padding(.all, 7.0)
                                .foregroundColor(Color.black)
                            //                            .padding(.horizontal)
                        }
                        
        
                        //Schedule set up
                        Section (header: Text("Schedule")
                                    .foregroundColor(Color.blue)
                                    .bold()
                        ){
                            DatePicker("Start Date", selection: $vm.startDate, in: Date()..., displayedComponents: .date)
                                .padding(.leading, 5.0)
                                .foregroundColor(Color.black)
                            HStack{
                                Text("Repeat")
                                    .padding(.all, 5.0)
                                    .foregroundColor(Color.black)
                                Spacer()
                                Picker(
                                    selection: $vm.repeats,
                                    label:
                                        HStack{
                                            Text(vm.repeats)
                                                .foregroundColor(Color.black)
                                                .font(.headline)
                                                .background(Color.black)
                                        },
                                    content: {
                                        ForEach(repeatOptions, id: \.self){
                                            option in
                                            HStack{
                                                Text(option)
                                            }
                                            .tag(option)
                                        }//forEachContent
                                    }//pickerContent
                                )//Picker
                                    .pickerStyle(MenuPickerStyle())
                                    .foregroundColor(Color.black)
                            }//Hstack
                        }
                        
                        
                    }//Vstack line 22
                    //content
                    
                    
                    //navbar Setting
                    .navigationBarTitle(
                        Text("Add Action").bold(),
                        displayMode: .inline)
                    .foregroundColor(Color.white)
                    .navigationBarItems(leading:
                                            //Cancel Button
                                        Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel").bold()
                    }, trailing: Button(action: {
                        vm.editAction(actionID: actionID)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save").bold()
                    })
                    .foregroundColor(Color.white)
                }//navigationView
                .navigationAppearance(backgroundColor: UIColor(primary900), foregroundColor: .white, hideSeperator: true)
                
            }//Vstack Line 16
        }//geometryReader
        .onAppear {
        }
        .onDisappear() {
            vm.fillProperties(actionID: actionID)
        }
    }

}

//struct EditActionView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditActionView(initialActionTitle: "None", initialStartDate: Date(), initialRepeatValue: .daily)
//            .environmentObject(Dailies())
//    }
//}

