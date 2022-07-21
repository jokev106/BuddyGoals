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
    
    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    
    //for White Content Navigation Bar
    init() {
       let navBarAppearance = UINavigationBar.appearance()
       navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
       navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
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
                            listPlansCard
                            
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
            //            vm.addInitialItems()
            
            
            vm.getUser()
            vm.getPlans(id: nil)
            vm.calculateRemainingDays()
        }

        
    } //View Close
    
    //Function
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
    
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
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
                    Text("\(vm.currentGoal?.wrappedDuration ?? 0) Weeks")
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
                        
                        Button(action: {
                            //Do Action
                            
                        }, label: {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(plusButtonWhite)
                                    .background(plan.planColor.colorValue)
                                    .clipShape(Circle())
                                    
                            
                        })//Button
                            
                        
                    }
                    .padding(.bottom, 20)
                    .padding(.trailing, 30)
                    .padding(.leading, 30)// HStack
                    
                    //Card
                    //ForEach {
                    ForEach (plan.wrappedActions) { action in
                        CardHomeView(colorCard: plan.planColor.colorValue, milestone: action.wrappedTitle, destinationCard: "")
                    }
                        
//                        CardHomeView(colorCard: green, milestone: "Plank for 3 minutes", destinationCard: "")
//                        CardHomeView(colorCard: green, milestone: "Sit up 10 times", destinationCard: "")
//                        CardHomeView(colorCard: green, milestone: "Vertical Jumps for 3 minutes", destinationCard: "")
//                        CardHomeView(colorCard: green, milestone: "Vertical Jumps for 3 minutes", destinationCard: "")
//                        CardHomeView(colorCard: green, milestone: "Vertical Jumps for 3 minutes", destinationCard: "")
//                        CardHomeView(colorCard: green, milestone: "Vertical Jumps for 3 minutes", destinationCard: "")
//                        CardHomeView(colorCard: green, milestone: "Vertical Jumps for 3 minutes", destinationCard: "")
//                        CardHomeView(colorCard: green, milestone: "Try Something", destinationCard: "")
                    //}
                    
                    //Close of Card
                }
            }
            
            
        }
    } //var listPlansCard
    
    
}




