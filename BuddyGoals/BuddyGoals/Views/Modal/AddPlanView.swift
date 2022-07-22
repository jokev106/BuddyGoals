//
//  AddPlanView.swift
//  BuddyGoals
//
//  Created by Jonathan Kevin on 24/06/22.
//
import SwiftUI

struct AddPlanView: View {
    
    //    @Environment(\.dismiss) var dismissSheetView
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
    @State private var milestoneTitle:  String = ""
    @State private var startDatePicker = Date()
    
    @EnvironmentObject var activityToday : Dailies
    
    var body: some View {
        GeometryReader{ geo in
            
            VStack{
                NavigationView{
                    VStack{
                        
                        //Milestone set up
                        Text("Milestone")
                            .foregroundColor(Color.blue)
                            .frame(maxWidth: .infinity , alignment: .leading)
                            .padding([.top, .leading], 26.0)
                        TextField("Ex: Exercise", text: $milestoneTitle)
                            .padding()
                            .foregroundColor(Color.black)
                            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                            .padding(.horizontal)
                        
//                        //Schedule set up
//                        Text("Schedule")
//                            .foregroundColor(Color.blue)
//                            .frame(maxWidth: .infinity , alignment: .leading)
//                            .padding([.top, .leading], 26.0)
//                        DatePicker("Start Date", selection: $startDatePicker, in: Date()...)
////                            .datePickerStyle(GraphicalDatePickerStyle())
//                            .padding()
//                            .foregroundColor(Color.black)
//                            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
//                            .padding(.horizontal)
                        Spacer()
                    }
                    //content
                    
                    
                    //navbar Setting
                    .navigationBarTitle(
                        Text("Plan").bold(),
                        displayMode: .inline)
                    .navigationBarItems(leading:
                                            //Cancel Button
                                        Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel").bold()
                    }, trailing: Button(action: {
                        activityToday.addNewPlan(title: $milestoneTitle.wrappedValue)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Create").bold()
                    })
                    .foregroundColor(Color.white)
                }//navigationView
                .navigationAppearance(backgroundColor: UIColor(primary900), foregroundColor: .white, hideSeperator: true)
            }//Vstack Line 23
        }//geometryReader
    }//bodyView
}

struct AddPlanView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlanView()
    }
}
