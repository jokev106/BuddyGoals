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
    @EnvironmentObject var dataPlan : PlanModel
    //if edit mode active
    @State var editMode = EditMode.inactive
    @State var show: Bool = false
    
    var body: some View {
        GeometryReader{ geo in
            
            NavigationView{
                
                //content
                VStack{
                    HStack{
                        TextField("Enter title", text: $dataPlan.planTitle)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(.black)
                        addButton
                    }
                    .padding(.horizontal)
                    List {
                        ForEach(Array(dataPlan.plans.enumerated()), id: \.offset){offset, plan in
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
                        .padding(.horizontal)
                        List {
                            ForEach(Array(dataPlan.plans.enumerated()), id: \.offset){offset, plan in
                                NavigationLink(destination: ProfileView()){
                                    HStack{
                                        Rectangle()
                                            .foregroundColor(.orange)
                                            .frame(width: 15, height: 50)
                                        VStack{
                                            Text(dataPlan.planTitle)
                                                .foregroundColor(.black)
                                        }
                                        .foregroundColor(.black)
                                    }.cornerRadius(5)
                                }
                            }
                            .onDelete(perform: dataPlan.onDelete)
                            .onMove(perform: dataPlan.onMove)
                        }
                        .listStyle(InsetListStyle())
                        
                        //Footer Button
                        
                        
                    }
                }
                .safeAreaInset(edge: .bottom){
                    NavigationLink{
                        AddPlanView()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(blue)
                        Text("Add New Plan")
                            .foregroundColor(blue)
                    }
                    .frame(width: 300, height: 0, alignment: .leading)
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
            dataPlan.setup(goalID: gvm.goalID!, context: gvm.context!)
            dataPlan.getPlans()
        }
        .onDisappear() {
            gvm.getPlans(id: nil)
        }
    }//bodyView
    private var addButton : some View {
        //if edit mode active / not active
        switch editMode {
        case .inactive:
            return AnyView(Button(action: {}) {
                HStack{
//                                        Text("Add")
                    Image(systemName: "plus")
                }
                .padding()
                .background(Color.orange)
                .foregroundColor(Color.white)
                .cornerRadius(5)
            })
        default:
            return AnyView(EmptyView())
        }
    }
    
    
}

struct PlanDetailView_Previews: PreviewProvider {
    
    @StateObject static var planModel = PlanModel()
    
    static var previews: some View {
        PlanDetailView()
            .environmentObject(planModel)
            .environmentObject(GoalViewModel())
    }
}

