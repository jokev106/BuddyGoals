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
    @EnvironmentObject var data: PlanModel
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
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
                            .frame(height: 300, alignment: .top)
                            .ignoresSafeArea(.all)
                            .shadow(radius: 10)
                        Spacer()
                    }
                    
                    VStack {
                        
                        //extention main goal card
                        mainGoalCard
                        
                        //Close of Card
                        
                        VStack(spacing:-10){
                            
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
                    .navigationTitle("Goal")

                    
                }
                
            
        } //Navigation View
        .edgesIgnoringSafeArea(.all)

        
    } //View Close
    
    //Function
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            
            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

extension GoalView {
    
    //card for main goal card
    var mainGoalCard: some View {
        
        Group {
            VStack{
                HStack {
                    Text("Be a good boyfriend")
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
                    Text("12 Weeks")
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
                    Text("15 Days")
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
        .padding()
        .shadow(radius: 5)
        
    } //var main goal
    
    //list of plans
    var listPlansCard: some View {
        ScrollView {
            
            VStack(spacing:-5){
                HStack{
                    
                    Text("Exercise")
                        .foregroundColor(green)
                        .font(.system(size: 22.5))
                        .bold()
                        
                    
                    Spacer()
                    
                    Button(action: {
                        //Do Action
                        
                    }, label: {
                        
                        Image(systemName: "plus")
                            .foregroundColor(green)
                        
                    })//Button
                    
                }.padding() // HStack
                
                //Card
                CardHomeView(colorCard: green, milestone: "Jumping Jack for 3 minutes", destinationCard: "")
                CardHomeView(colorCard: green, milestone: "Plank for 3 minutes", destinationCard: "")
                CardHomeView(colorCard: green, milestone: "Sit up 10 times", destinationCard: "")
                CardHomeView(colorCard: green, milestone: "Vertical Jumps for 3 minutes", destinationCard: "")
                CardHomeView(colorCard: green, milestone: "Try Something", destinationCard: "")
                //Close of Card
            }
            
        }
        .padding()
    } //var listPlansCard
    
    
}


