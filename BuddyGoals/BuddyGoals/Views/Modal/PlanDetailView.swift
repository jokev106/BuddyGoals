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
    
    @EnvironmentObject var dataPlan : PlanModel
    //if edit mode active
    @State var editMode = EditMode.inactive
    @State var show: Bool = false
    
    var body: some View {
        GeometryReader{ geo in
            
            NavigationView{
                
                //content
                VStack{
                    ScrollView{
                        ZStack{
                            VStack{
                                Spacer()
                                    .frame(height: 20)
                                ForEach(Array(dataPlan.plans.enumerated()), id: \.offset){offset, plan in
                                    NavigationLink(destination: ProfileView()){
                                        
                                        HStack{
                                            CardHomeView(colorCard: green, milestone: dataPlan.planTitle, destinationCard: "")
                                            .foregroundColor(.black)
                                        }.cornerRadius(5)
                                    }
                                }
                                .onDelete(perform: dataPlan.onDelete)
                                .onMove(perform: dataPlan.onMove)
                                Spacer()
                                
                            }
                        }
                    }
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
    }
}

