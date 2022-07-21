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
    
    @State var planTitle:  String = ""
    @State var colorPlan: String = ""
    
    @EnvironmentObject var dataPlan : PlanModel
    
//    @State var diamondPlusColor = diamondPlus
    
    @State var isTappedCircleBlue = false
    @State var isTappedCircleYellow = false
    @State var isTappedCircleOrange = false
    @State var isTappedCirclePurple = false
    @State var isTappedCircleRed = false
    
    var body: some View {
        GeometryReader{ geo in
            
            VStack{
                NavigationView{
                    
                    //content
                    VStack{
                        HStack{
                            Spacer()
                            Button(action: {
                                dataPlan.onAdd(plan: $planTitle.wrappedValue, color: $colorPlan.wrappedValue)
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Text("Create").bold()
                                    .foregroundColor(.white)
                            }
                            Spacer()
                                .frame(width: 20)
                        }
                        Spacer()
                            .frame(height: 35)
                        //Diamond plus image
                        Image(systemName: "plus.diamond.fill")
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .center)
                            .foregroundColor(blue)
                            
                        Spacer()
                            .frame(height: 35)
                        
                        //Milestone set up
                        TextField("Ex: Exercise", text: $planTitle)
                            .padding()
                            .foregroundColor(Color.black)
                            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                            .padding(.horizontal)
                        Spacer()
                            .frame(height: 35)
                        
                        HStack{
                            Image(systemName: isTappedCircleBlue ? "record.circle.fill" : "circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    self.isTappedCircleBlue.toggle()
                                    if isTappedCircleBlue == true {
                                        isTappedCircleRed = false
                                        isTappedCircleYellow = false
                                        isTappedCirclePurple = false
                                        isTappedCircleOrange = false
                                        
                                    }
                                }
                            
                            Spacer()
                                .frame(width: 20)
                            
                            Image(systemName: isTappedCircleYellow ? "record.circle.fill" : "circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.yellow)
                                .onTapGesture {
                                    self.isTappedCircleYellow.toggle()
                                    if isTappedCircleYellow == true {
                                        isTappedCircleRed = false
                                        isTappedCircleBlue = false
                                        isTappedCirclePurple = false
                                        isTappedCircleOrange = false
                                    }
                                }
                            
                            Spacer()
                                .frame(width: 20)
                            
                            Image(systemName: isTappedCircleOrange ? "record.circle.fill" : "circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.orange)
                                .onTapGesture {
                                    self.isTappedCircleOrange.toggle()
                                    if isTappedCircleOrange == true {
                                        isTappedCircleRed = false
                                        isTappedCircleBlue = false
                                        isTappedCirclePurple = false
                                        isTappedCircleYellow = false
                                    }
                                }
                            
                            Spacer()
                                .frame(width: 20)
                            
                            Image(systemName: isTappedCirclePurple ? "record.circle.fill" : "circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.purple)
                                .onTapGesture {
                                    self.isTappedCirclePurple.toggle()
                                    if isTappedCirclePurple == true {
                                        isTappedCircleRed = false
                                        isTappedCircleBlue = false
                                        isTappedCircleYellow = false
                                        isTappedCircleOrange = false
                                    }
                                }
                            
                            Spacer()
                                .frame(width: 20)
                            
                            Image(systemName: isTappedCircleRed ? "record.circle.fill" : "circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.red)
                                .onTapGesture {
                                    self.isTappedCircleRed.toggle()
                                    if isTappedCircleRed == true {
                                        isTappedCircleYellow = false
                                        isTappedCircleBlue = false
                                        isTappedCirclePurple = false
                                        isTappedCircleOrange = false
                                    }
                                }
                        }
                        //Hstack style
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                        
                        Spacer()
                    }
                    //navbar Setting
                    .foregroundColor(Color.white)
                    .navigationBarHidden(true)
                }//navigationView
                .navigationAppearance(backgroundColor: UIColor(primary900), foregroundColor: .white, hideSeperator: true)
            }//Vstack Line 23
        }//geometryReader
    }//bodyView
    
//    private var diamondPlus: some View{
//        //if collor tapped switch color on diamond plus symbol
//
//
//    }
}


struct AddPlanView_Previews: PreviewProvider {
    @StateObject static var planModel = PlanModel()
    static var previews: some View {
        AddPlanView()
            .environmentObject(planModel)
    }
}
