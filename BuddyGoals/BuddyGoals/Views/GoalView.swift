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
    @ObservedObject var vm = GoalViewModel()
    
    
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
                            .frame(height: 300, alignment: .top)
                            .ignoresSafeArea(.all)
                        Spacer()
                    }
                    VStack {
                        
                        //Spacer(minLength: 10)
                        
                        Group {
                            VStack{
                                HStack {
                                    Text(vm.goal.first?.wrappedTitle ?? "No Goal Available")
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
                                }
                                
                                HStack {
                                    Text("Durations")
                                        .foregroundColor(Color.black)
                                        .bold()
                                    Spacer()
                                    Text("\(vm.goal.first?.wrappedDuration ?? -1) Weeks")
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
                        .padding()
                        .shadow(radius: 5)
                        
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
                            
                            ScrollView {
                                
                                ForEach(vm.plans) { plan in
                                    PlanView(plan: plan)
                                }
                                
                                
                            }
                            
                        } //VStack
                   
                    } //VStack
                    .navigationTitle("Goal")
//                    .toolbar {
//                        ToolbarItemGroup(placement: .navigationBarTrailing){
//                            Button(action: {
//                                //Do action
//                                self.tapRankView.toggle()
//                            }, label: {
//                                HStack {
//                                    Image(systemName: "diamond.fill")
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//
//                                    Text("27")
//                                    Text("Rookie")
//                                        .bold()
//                                }
//                                .padding(5)
//                                .font(.system(size: 12.5))
//                                .foregroundColor(whiteDark)
//                                .background(.white)
//                                .cornerRadius(10)
//                                .shadow(radius: 2)
//                            }).sheet(isPresented: $tapRankView) {
//                                RankView()
//                            }
//                        }
//                    } //Toolbar
                    
                }
                
            //}.edgesIgnoringSafeArea(.all)
            
        } //Navigation View
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            vm.setup(context: self.viewContext)
            ////            Uncomment to get initial items in core data
            //            vm.addInitialItems()
            
            
            vm.getUser()
            vm.getPlan(id: nil)
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
    }
}

//List
//List {
//    ForEach(items) { item in
//        NavigationLink {
//            Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//        } label: {
//            Text(item.timestamp!, formatter: itemFormatter)
//        }
//    }
//    .onDelete(perform: deleteItems)
//}
//.toolbar {
//    ToolbarItem(placement: .navigationBarTrailing) {
//        EditButton()
//    }
//    ToolbarItem {
//        Button(action: {self.addNewPlanView.toggle()}) {
//            Label("Add Item", systemImage: "plus")
//                .foregroundColor(Color.blue)
//        }.sheet(isPresented: $addNewPlanView) {
//            AddPlanView()
//        }
//    }
//}
//Text("Select an item")




