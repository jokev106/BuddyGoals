//
//  PlanDetailView.swift
//  BuddyGoals
//
//  Created by Jonathan Kevin on 14/07/22.
//

import SwiftUI

struct PlanDetailView: View {
    
    //    @Environment(\.dismiss) var dismissSheetView
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
    @EnvironmentObject var gvm : GoalViewModel
    @EnvironmentObject var data : PlanModel
    //if edit mode active
    @State var editMode = EditMode.inactive
    @State var show: Bool = false
    
    var body: some View {
        GeometryReader{ geo in
            
            NavigationView{
                
                //content
                VStack{
                    
                    List {
                        ForEach(Array(data.plans.enumerated()), id: \.offset) {offset, plan in
                            NavigationLink(destination: ProfileView()){
                                HStack{
                                    Rectangle()
                                        .foregroundColor(plan.planColor.colorValue)
                                        .frame(width: 15, height: 50)
                                    VStack{
                                        Text(plan.wrappedTitle)
                                            .foregroundColor(.black)
                                    }
                                    .foregroundColor(.black)
                                }.cornerRadius(5)
                            }
                        }
                        .onDelete(perform: data.onDelete)
                        .onMove(perform: data.onMove)
                    }
                    .listStyle(InsetListStyle())
                    //Footer Button
                                        ZStack{
                                            NavigationLink{
                                                AddPlanView()
                                            } label: {
                                                Image(systemName: "plus")
                                                    .foregroundColor(blue)
                                                Text("Add New Plan")
                                                    .foregroundColor(blue)
                                                //                                    .frame(width: 350, height: 20, alignment: .leading)
                                            }
                                            .frame(width: 300, height: 0, alignment: .leading)
                                        }.padding(.top)
                }
                //navbar Setting
                .navigationBarTitle(
                    Text("Plan").bold(),
                    displayMode: .inline)
                .navigationBarItems(
                    leading:
                        //Cancel Button
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Done").bold()
                    }, trailing: EditButton())
                .environment(\.editMode, $editMode)
                .foregroundColor(Color.white)
            }//navigationView
            .navigationAppearance(backgroundColor: UIColor(primary900), foregroundColor: .white, hideSeperator: true)
        }//geometryReader
        .onAppear() {
            data.setup(goalID: gvm.goalID!, context: gvm.context!)
            data.getPlans()
        }
        .onDisappear() {
            gvm.getPlans(id: nil)
        }
    }//bodyView
    
}

struct PlanDetailView_Previews: PreviewProvider {
    
    @StateObject static var planModel = PlanModel()
    
    static var previews: some View {
        PlanDetailView()
            .environmentObject(planModel)
    }
}
