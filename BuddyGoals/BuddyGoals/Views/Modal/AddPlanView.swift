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
    
    
    @EnvironmentObject var dataPlan : PlanModel
    
//    @State var diamondPlusColor = diamondPlus
    
    @State var isTappedCircleBlue = false
    @State var isTappedCircleGreen = false
    @State var isTappedCircleOrange = false
    @State var isTappedCirclePurple = false
    @State var isTappedCircleRed = false
    
    var body: some View {
        GeometryReader{ geo in
            
            VStack{
                NavigationView{
                    
                    //content
                    VStack{
                        ZStack{
                            Rectangle()
                                .frame(width: .infinity, height: 56)
                                .foregroundColor(primary900)
                            HStack{
                                Spacer()
                                    .frame(width: 20)
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    Text("Cancel").bold()
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                }

                                Spacer()
                                Text("New Plan").bold()
                                Spacer()
                                Button(action: {
                                    dataPlan.addPlan()
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    Text("Create").bold()
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                }
                                Spacer()
                                    .frame(width: 20)
                            }
                        }
                        Spacer()
                            .frame(height: 35)
                        //Diamond plus image
                        Image(systemName: "plus.diamond.fill")
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .center)
                            .foregroundColor(dataPlan.colorPlan.colorValue)
                            
                        Spacer()
                            .frame(height: 35)
                        
                        //Milestone set up
                        TextField("Ex: Exercise", text: $dataPlan.planTitle)
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
                                    dataPlan.colorPlan = .colorBlue
                                    self.isTappedCircleBlue.toggle()
                                    if isTappedCircleBlue == true {
                                        isTappedCircleRed = false
                                        isTappedCircleGreen = false
                                        isTappedCirclePurple = false
                                        isTappedCircleOrange = false
                                        
                                    }
                                }
                            
                            Spacer()
                                .frame(width: 20)
                            
                            Image(systemName: isTappedCircleGreen ? "record.circle.fill" : "circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.green)
                                .onTapGesture {
                                    // Warnanya green
                                    dataPlan.colorPlan = .colorGreen
                                    self.isTappedCircleGreen.toggle()
                                    if isTappedCircleGreen == true {
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
                                    dataPlan.colorPlan = .colorOrange
                                    self.isTappedCircleOrange.toggle()
                                    if isTappedCircleOrange == true {
                                        isTappedCircleRed = false
                                        isTappedCircleBlue = false
                                        isTappedCirclePurple = false
                                        isTappedCircleGreen = false
                                    }
                                }
                            
                            Spacer()
                                .frame(width: 20)
                            
                            Image(systemName: isTappedCirclePurple ? "record.circle.fill" : "circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.purple)
                                .onTapGesture {
                                    dataPlan.colorPlan = .colorPurple
                                    self.isTappedCirclePurple.toggle()
                                    if isTappedCirclePurple == true {
                                        isTappedCircleRed = false
                                        isTappedCircleBlue = false
                                        isTappedCircleGreen = false
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
                                    dataPlan.colorPlan = .colorRed
                                    self.isTappedCircleRed.toggle()
                                    if isTappedCircleRed == true {
                                        isTappedCircleGreen = false
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
                .navigationBarHidden(true)
                .onDisappear() {
                    dataPlan.getPlans()
                }
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
