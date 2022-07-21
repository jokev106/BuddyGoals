//
//  PlanModel.swift
//  BuddyGoals
//
//  Created by Jonathan Kevin on 14/07/22.
//

import Foundation
import Combine
import SwiftUI
import CoreData

class PlanModel: ObservableObject {
    @Published var planTitle : String = ""
    @Published var colorPlan : PlanColor = .colorBlue
    @Published var plans : [CoreDataPlan] = []
    
    var goalID : UUID?
    var goal : CoreDataGoal?
    
    var context : NSManagedObjectContext?
    var coreDataController : CoreDataController?
    
    // Setup awal untuk memakai View Model tapi menghindari init
    func setup(goalID: UUID, context : NSManagedObjectContext) {
        self.context = context
        coreDataController = CoreDataController(context: context)
        self.goalID = goalID
        self.goal = (self.coreDataController?.selectOneWhereCoreData(entityName: "CoreDataGoal", toPredicate: "id", predicateValue: "\(goalID)").first as! CoreDataGoal)
    }
    
    func onAdd(plan: String, color: PlanColor) {
//        plans.append(Plan(planTitle: plan, colorPlan: color))
//        self.planTitle = ""
//        self.colorPlan = ""
        
        let newPlan = CoreDataPlan(context: context!)
        newPlan.id = UUID()
        newPlan.title = plan
        newPlan.planColor = color
        newPlan.index = Int16(plans.count)
        
        newPlan.goalID = goal!.id
        newPlan.goal = goal!
        
        
        save()
        
        getPlans()
    }
    
    func getPlans() {
        let tempPlan = self.coreDataController?.selectOneWhereCoreData(entityName: "CoreDataPlan", toPredicate: "goalID", predicateValue: "\(self.goalID!)") as! [CoreDataPlan]
        self.plans = tempPlan.sorted { $0.wrappedIndex <= $1.wrappedIndex }
    }
    
    func onDelete(offset: IndexSet) {
        offset.map { plans[$0] }.forEach(context!.delete)
        save()
        getPlans()
    }
    
    func onMove(source: IndexSet, destination: Int){
        plans.move(fromOffsets: source, toOffset: destination)
        updateIndex()
    }
    
    func updateIndex() {
        for (index, plan) in self.plans.enumerated() {
            plan.wrappedIndex = index
        }
        save()
    }
 
    // Update Plans value
    func onUpdate(index: Int, plan: String, colorPlan: PlanColor) {
        plans[index].title = planTitle
        plans[index].planColor = colorPlan
        
        save()
    }
    
    func save() {
        do {
            try context?.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error \(error)")
        }
    }
}
