//
//  RankView.swift
//  BuddyGoals
//
//  Created by I Gede Bagus Wirawan on 28/06/22.
//

import SwiftUI

struct RankView: View {
    //    @Environment(\.dismiss) var dismissSheetView
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
    @State private var milestoneTitle:  String = ""
    @State private var startDatePicker = Date()
    
    var body: some View {
        GeometryReader{ geo in
            
            VStack{
                NavigationView{
                    
                    ScrollView {
                        
                        VStack {
                                
                            HStack {
                                Spacer()

                                Button(action: {
                                    //Do Action
                                    
                                }, label: {
                                    Text("Edit")
                                        .font(.system(size: 10))
                                        .padding(5)
                                        .background(white)
                                        .foregroundColor(primary900)
                                        .cornerRadius(10)
                                })
                            }.padding() //HStack for button edit
                                
                                
                            ZStack {
                                VStack {
                                    Image("Gusde-Emot")
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: 125, height: 125, alignment: .center)
                                    Spacer(minLength: 100)
                                }
                                
                                //Card
                                HStack {
                                    Image(systemName: "diamond.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20, alignment: .trailing)
                                    
                                    Text("27")
                                    Text("Intermidiate")
                                        .bold()
                                }
                                .padding(5)
                                .font(.system(size: 12.5))
                                .foregroundColor(primary900)
                                .background(.white)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                                //End Card
                            } //ZStack
                                
                            //Continue Profile
                            Text("Bagus Wirawan")//Name
                                .foregroundColor(.black)
                                .font(.system(size: 25))
                            HStack {
                                Text("gghch")
                                    .foregroundColor(whiteDark)
                                Image(systemName: "doc.on.doc")
                                    .foregroundColor(whiteDark)
                            }
                            
                            Text("Do Actions to Rank up!")
                                .foregroundColor(.black)
                                .font(.system(size: 25))
                                .bold()
                                .padding(.top, 25)
                                .padding(.bottom, 10)
                            
                            Text("The more difficult the Action, the faster your rank up")
                                .foregroundColor(.black)
                                .font(.system(size: 12.5))
                                .frame(width: 300, alignment: .center)
                                .padding(.bottom, 25)
                            
                            Group {
                                
                                VStack {
                                    //Level
                                    HStack {
                                        Image(systemName: "diamond.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20, alignment: .trailing)
                                        
                                        Text("0")
                                        Text("Rookie")
                                            .bold()
                                    }
                                    .padding(2.5)
                                    .font(.system(size: 12.5))
                                    .foregroundColor(whiteDark)
                                    
                                    //Level
                                    HStack {
                                        Image(systemName: "diamond.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20, alignment: .trailing)
                                        
                                        Text("10")
                                        Text("Beginner")
                                            .bold()
                                    }
                                    .padding(2.5)
                                    .font(.system(size: 12.5))
                                    .foregroundColor(green)
                                    
                                    //Level
                                    HStack {
                                        Image(systemName: "diamond.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20, alignment: .trailing)
                                        
                                        Text("30")
                                        Text("Intermidiate")
                                            .bold()
                                    }
                                    .padding(2.5)
                                    .font(.system(size: 12.5))
                                    .foregroundColor(primary900)
                                    
                                    //Level
                                    HStack {
                                        Image(systemName: "diamond.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20, alignment: .trailing)
                                        
                                        Text("60")
                                        Text("Pro")
                                            .bold()
                                    }
                                    .padding(2.5)
                                    .font(.system(size: 12.5))
                                    .foregroundColor(purple)
                                    
                                    //Level
                                    HStack {
                                        Image(systemName: "diamond.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20, alignment: .trailing)
                                        
                                        Text("100")
                                        Text("Expert")
                                            .bold()
                                    }
                                    .padding(2.5)
                                    .font(.system(size: 12.5))
                                    .foregroundColor(orange)
                                }
                                
                            }
                            .padding()
                            .frame(width: 350, height: .infinity, alignment: .center)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            
                            Text("*Your rank will be reset for each new Goal")
                                .foregroundColor(whiteDark)
                                .padding()
                                .font(.system(size: 12.5))
                                    
                        } //VStack
                    } //ScrollView
                    //content
                    //navbar Setting
                    .navigationBarTitle(
                        Text("Your Rank").bold(),
                        displayMode: .inline)
                    .navigationBarItems(leading:
                    //Done Button
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Done").bold()
                    })
                    .foregroundColor(Color.white)
                }//navigationView
                .navigationAppearance(backgroundColor: UIColor(primary900), foregroundColor: .white, hideSeperator: true)
            }//Vstack Line 23
        }//geometryReader
    }//bodyView
}

struct RankView_Previews: PreviewProvider {
    static var previews: some View {
        RankView()
    }
}
