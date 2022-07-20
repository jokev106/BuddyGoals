//
//  RankView.swift
//  BuddyGoals
//
//  Created by I Gede Bagus Wirawan on 28/06/22.
//

import SwiftUI

struct BuddyProfileView: View {
    //    @Environment(\.dismiss) var dismissSheetView
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
    @State private var milestoneTitle:  String = ""
    @State private var startDatePicker = Date()
    
    //variable for form
    @State private var currentName : String = ""
    @State private var currentGoal : String = ""
    @State private var scheduleStart = Date()
    @State private var scheduleEnd = Date()

    
    
    var body: some View {
        GeometryReader{ geo in
            
            VStack{
                NavigationView{
                    
                    VStack {
                        
                        //Form
                        formProfile
                       
                        
                    }//VStack
                    //navbar Setting
                    .navigationBarTitle(
                        Text("Buddy Profile").bold(),
                        displayMode: .inline)
                    .navigationBarItems(
                    leading:
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Back").bold()
                        }
                    )
                    .foregroundColor(Color.white)
                    
                }//navigationView
                .navigationAppearance(backgroundColor: UIColor(.red), foregroundColor: .white, hideSeperator: true)
            }//Vstack Line 23
        }//geometryReader
    }//bodyView
}

struct BuddyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        BuddyProfileView()
    }
}

extension BuddyProfileView {
    
    // Form Profile
    var formProfile: some View {
        
        VStack {
            Image("Gusde-Emot")
                .resizable()
                .clipShape(Circle())
                .frame(width: 125, height: 125, alignment: .center)
                .padding(.top)
                
            //Continue Profile
            Text("Giga Chadson")//Name
                .foregroundColor(.black)
                .font(.system(size: 25))
                .multilineTextAlignment(.center)
            
            Form {
                
                //Form
                Section (header: Text("Buddy's Goal")
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

                        }, label: {
                            Text("Remove Buddy")
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
    
    
}
