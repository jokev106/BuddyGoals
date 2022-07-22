//
//  AddActionView.swift
//  BuddyGoals
//
//  Created by Jonathan Kevin on 24/06/22.
//

import SwiftUI

struct AddActionView: View {
    
    //modal view(presentation) mode
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
    //var for form input
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
    var imageDifficulty: [String] = [
        "dTrivial", "dEasy", "dMedium", "dHard", "dExpert"
    ]
    
    //Bool difficulty
        @State var isTappedDifficultyTrivial = false
        @State var isTappedDifficultyEasy = false
        @State var isTappedDifficultyMedium = false
        @State var isTappedDifficultyHard = false
        @State var isTappedDifficultyExpert = false
    
    
//    @State var isTappedDifficulty = false
      @State var isTappedDetails = false

    // For Editing Purposes
    var action: Actionable?
    var planId: UUID?
    
    @EnvironmentObject var activityToday : Dailies
    
    var body: some View {
        GeometryReader{ geo in
            
            VStack{
                
                NavigationView{
                    Form{
                        
                        //Submission image
                        Section(header: Text("Submission")
                                    .foregroundColor(Color.blue)
                                    .bold()
                        ){
                            HStack{
                                Spacer()
                                //Add photo from library
                                Button(action:{
                                    changeSubmissionImage = true
                                    openCameraSheet = true
                                }){
                                    if changeSubmissionImage {
                                        Image(uiImage: imageSelected)
                                            .resizable()
                                            .foregroundColor(primary900)
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 200, height: 200, alignment: .center)
                                    }else {
                                        HStack{
                                            Spacer()
                                            Image(systemName: "photo.fill")
                                                .resizable()
                                                .foregroundColor(primary900)
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 50, height: 50, alignment: .center)
                                            Spacer()
                                            Rectangle()
                                                .frame(width: 1, height: 100)
                                                .foregroundColor(Color.gray
                                                )
                                                .padding(5)
                                            Spacer()
                                            Image(systemName: "camera.fill")
                                                .resizable()
                                                .foregroundColor(primary900)
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 50, height: 50, alignment: .center)
                                            Spacer()
                                        }
                                    }
                                }.sheet(isPresented: $changeSubmissionImage) {
                                    SubmissionPicker(selectedImage: $imageSelected, sourceType: .photoLibrary)
                                }
                                Spacer()
    
                            } //HStack
                            
                        }
                        
                        //Action title set up section
                        Section (header: Text("Title")
                                    .foregroundColor(Color.blue)
                                    .bold()
                        ){
                            TextField("Ex: Morning Run", text: $actionTitle)
                                .padding(.all, 7.0)
                                .foregroundColor(Color.black)
                            //                            .padding(.horizontal)
                        }
                        
        
                        //Schedule set up
                        Section (header: Text("Schedule")
                                    .foregroundColor(Color.blue)
                                    .bold()
                        ){
                            DatePicker("Start Date", selection: $scheduleDatePicker, in: Date()..., displayedComponents: .date)
                                .padding(.leading, 5.0)
                                .foregroundColor(Color.black)
                            HStack{
                                Text("Repeat")
                                    .padding(.all, 5.0)
                                    .foregroundColor(Color.black)
                                Spacer()
                                Picker(
                                    selection: $repeatPicker,
                                    label:
                                        HStack{
                                            Text(repeatPicker)
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
//                        activityToday.updateAction(planId: planId!, actionId: action!.id, action: $actionTitle.wrappedValue)
                        let difficulty : Rank = {
                            if isTappedDifficultyTrivial {
                                return .trivial
                            } else if isTappedDifficultyMedium {
                                return .medium
                            } else if isTappedDifficultyEasy {
                                return.easy
                            } else if isTappedDifficultyHard {
                                return .hard
                            } else {
                                return .expert
                            }
                        }()
                        if let action = action {
                            activityToday.updateAction(planId: planId!, actionId: action.id, action: $actionTitle.wrappedValue, time: $detailsDatePicker.wrappedValue, place: $detailsWhere.wrappedValue, startDate: $detailsDatePicker.wrappedValue, repeats: RepeatAction(rawValue: $repeatPicker.wrappedValue)!, difficulty: difficulty)
                        } else {
                            activityToday.addNewAction(action: $actionTitle.wrappedValue, time: $detailsDatePicker.wrappedValue, place: $detailsWhere.wrappedValue, startDate: $detailsDatePicker.wrappedValue, repeats: RepeatAction(rawValue: $repeatPicker.wrappedValue)!, difficulty: difficulty)
                        }
                        
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Create").bold()
                    })
                    .foregroundColor(Color.white)
                }//navigationView
                .navigationAppearance(backgroundColor: UIColor(primary900), foregroundColor: .white, hideSeperator: true)
                .onAppear {
                    if let action = action {
                        actionTitle = action.action
                        detailsWhere = action.place
                        repeatPicker = action.repeats.rawValue
                        switch action.difficulty {
                        case .trivial :
                            isTappedDifficultyTrivial = true
                        case .easy:
                            isTappedDifficultyEasy = true
                        case .medium:
                            isTappedDifficultyMedium = true
                        case .hard:
                            isTappedDifficultyHard = true
                        case .expert:
                            isTappedDifficultyExpert = true
                        }
                        scheduleDatePicker = action.time
                    }
                }
            }//Vstack Line 16
        }//geometryReader
    }

}

struct AddActionView_Previews: PreviewProvider {
    static var previews: some View {
        AddActionView()
            .environmentObject(Dailies())
    }
}

