//
//  ContentView.swift
//  BuddyGoals
//
//  Created by I Gede Bagus Wirawan on 28/06/22.
//

import SwiftUI
import CoreData

struct GoalView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var data : PlanModel
    @EnvironmentObject var vm : GoalViewModel
    
    
    //Modal Bool
    @State var addNewPlanView = false
    @State var addNewActionView = false
    @State var tapProfileView = false
    @State var tapEditGoal = false

    var body: some View {
        
        NavigationView {
            
            //ScrollView{
                ZStack {
                    
                    VStack{
                        primary900
                            .frame(height: 260, alignment: .top)
                            .ignoresSafeArea(.all)
                            .shadow(radius: 10)
                        Spacer()
                    }
                    
                    VStack {
                        
                        HStack{
                            Text("Goal")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.top, 16)
                                .padding(.leading, 30)
                                .padding(.bottom, 1)
                            
                            Spacer()
                        }
                        
                        
                        //extention main goal card
                        mainGoalCard
                        
                        
                        //Close of Card
                        VStack {
                            
                            HStack {
                                
                                Button(action: {self.addNewPlanView.toggle()}) {
                                    HStack{
                                        Image(systemName: "list.triangle")
                                        Text("Manage Plan")
                                    }.font(.system(size: 14))
                                }.sheet(isPresented: $addNewPlanView) {
                                    PlanDetailView()
                                        .environmentObject(PlanModel())
                                }
                                
                            }.padding(25)
                            
                            //extention list card plan
                            if !vm.plans.isEmpty {
                                listPlansCard
                            } else {
                                emptyStatePlan
                            }
                            
                            Spacer()
                            
                        } //VStack
                   
                    } //VStack
                    //.navigationTitle("Goal")
                    .navigationBarHidden(true)

                    
                }
                
            
        } //Navigation View
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            vm.setup(context: self.viewContext)
            ////            Uncomment to get initial items in core data
//                        vm.addInitialItems()
            
            
            vm.getUser()
            vm.getPlans(id: nil)
            vm.calculateRemainingDays()
        }

        
    } //View Close
    
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
            .environmentObject(GoalViewModel())
    }
}

extension GoalView {
    
    //card for main goal card
    var mainGoalCard: some View {
        
        Group {
            
            VStack{
                HStack {
                    Text(vm.currentGoal?.wrappedTitle ?? "Unknown Goal")
                        .font(.system(size: 25, weight: .bold))
                        .frame(alignment: .topTrailing)
                        .foregroundColor(Color.black)

                    Spacer()

                    Button(action: {
                        self.tapProfileView.toggle()
                    }, label: {
                        Image(systemName: "person.circle.fill")
                            .padding( .bottom, 10)
                    })
                    .sheet(isPresented: $tapProfileView) {
                        ProfileView()
                    }//Button card

                }
                
                HStack {
                    Rectangle()
                        .frame(height:1)
                        .padding(5)
                        .foregroundColor(primary900)
                }
                
                HStack {
                    Text("Durations")
                        .foregroundColor(Color.black)
                        .bold()
                    Spacer()
                    Text("\(vm.currentGoal?.wrappedDuration ?? -1) Weeks")
                        .foregroundColor(Color.gray)
                    
                    VStack {
                        Rectangle()
                            .frame(width: 0.75, height: 15)
                            .foregroundColor(Color.gray)
                    }
                    
                    Text("Remaining")
                        .foregroundColor(Color.black)
                        .bold()
                    Spacer()
                    Text("\(vm.remainingDay) Days")
                        .foregroundColor(Color.gray)
                }
                .font(.system(size: 8))
                .padding(7)
                .background(white)
                .cornerRadius(10)
                

            }
            .padding()
            .background(.white)
                
        } //Group Card
        .cornerRadius(10)
        .padding(.trailing, 16)
        .padding(.leading, 16)
        .shadow(radius: 5)
        
    } //var main goal
    
    //list of plans
    var listPlansCard: some View {
        ScrollView {
            
            ForEach(vm.plans) { plan in
                VStack(spacing:-5){
                    
                    HStack{
                        
                        Text(plan.wrappedTitle)
                            .foregroundColor(plan.planColor.colorValue)
                            .font(.system(size: 22.5))
                            .bold()
                            
                        Spacer()
                        
                        NavigationLink {
                            AddActionView(plan: plan)
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(plan.planColor.colorValue)
                                .background(plusButtonWhite)
                                .clipShape(Circle())
                        }
//                        Button(action: {self.addNewActionView.toggle()}) {
//                            Image(systemName: "plus.circle.fill")
//                                .foregroundColor(plusButtonWhite)
//                                .background(plan.planColor.colorValue)
//                                .clipShape(Circle())
//                        }.sheet(isPresented: $addNewActionView) {
//                            AddActionView(plan: plan)
//                        }
                        
                    }
                    .padding(.bottom, 20)
                    .padding(.trailing, 30)
                    .padding(.leading, 30)// HStack
                    
                    //Card
                    //ForEach {
                    ForEach (vm.actions.filter { $0.plan == plan }) { action in
                        NavigationLink {
//                            EditActionView(initialActionTitle: action.wrappedTitle, initialStartDate: action.wrappedDate, initialRepeatValue: action.repeats, actionID: action.id!)
                            ActionSubmissionView(actionID:action.id!)
                        } label: {
                            CardHomeView(colorCard: plan.planColor.colorValue, milestone: action.wrappedTitle)
                        }
                    }
                        
                    
                    //Close of Card
                }
            }
            
            
        }
    } //var listPlansCard
    
    var emptyStatePlan: some View {
        
        VStack {
            Image("Invite-Buddy")
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
            
            Text("Break down your goal")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.top)
                .frame(width: 300)
            
            Text("Tap the \(Image(systemName: "list.triangle")) Manage Plan button!")
                .font(.caption)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .frame(width: 300)
                .foregroundColor(whiteDark)
        }
        
    } //emptyStatePlan
    
    
}




