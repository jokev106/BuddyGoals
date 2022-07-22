//
//  GoalViewModel.swift
//  BuddyGoals
//
//  Created by Terrence Pramono on 19/07/22.
//

import Foundation
import CoreData

class GoalViewModel : ObservableObject {
    
    var context : NSManagedObjectContext?
    var coreDataController : CoreDataController?
    var goalID : UUID?
    
    @Published var user : [CoreDataUser] = []
    @Published var goal : [CoreDataGoal] = []
    @Published var plans : [CoreDataPlan] = []
    @Published var actions : [CoreDataAction] = []
    @Published var remainingDay : Int = 0
    
    // Setup awal
    func setup(context : NSManagedObjectContext) {
        self.context = context
        coreDataController = CoreDataController(context: context)
    }
    
    var currentGoal : CoreDataGoal? {
        return goal.first ?? nil
    }
    
    // query user sesuai user yang login
    func getUser() {
//        user = self.coreDataController?.selectOneWhereCoreData(entityName: "CoreDataUser", toPredicate: "name", predicateValue: "My Nam") as! [CoreDataUser]
        user = self.coreDataController?.selectAllCoreData(entityName: "CoreDataUser") as? [CoreDataUser] ?? []
        if user.count >= 1 {
            var tempGoal = user[0].wrappedGoals
            tempGoal = tempGoal.filter { $0.isFinished == false }
            goal = tempGoal
            goalID = goal[0].id
        }
    }
    
    // query plans from goal
    func getPlans(id : UUID?) {
        let usedID = id ?? self.goalID!
        let tempPlans = self.coreDataController?.selectOneWhereCoreData(entityName: "CoreDataPlan", toPredicate: "goalID", predicateValue: "\(usedID)") as! [CoreDataPlan]
//        for plan in tempPlans {
//            plans[plan] = plan.wrappedActions
//        }
        plans = tempPlans.sorted { $0.index <= $1.index}
        actions = []
        for plan in plans {
            actions += plan.wrappedActions
        }
    }
    
    // calculate end date from start date
    private func calculateEndDate() -> Date? {
        var dateComponent = DateComponents()
        let tempGoal = goal.first ?? nil
        if tempGoal != nil {
            dateComponent.day = 7 * tempGoal!.wrappedDuration
            let calculatedEndDate = Calendar.current.date(byAdding: dateComponent, to: tempGoal!.startDate!)
            return calculatedEndDate!
        }
        return nil
    }
    
    // calculate remaining days from end date to start date
    func calculateRemainingDays() {
        let endDate = calculateEndDate()
        if endDate != nil {
            let diffSeconds = endDate!.timeIntervalSinceReferenceDate - Date().timeIntervalSinceReferenceDate
            let diffDays = Int(diffSeconds / (60.0 * 60.0 * 24.0))
            self.remainingDay = diffDays
        }
    }
    
    // Add initial items for core data
    func addInitialItems() {
        let user = CoreDataUser(context: context!)
        user.id = UUID()
        user.name = "My Name"
        user.password = "123456"
        user.email = "itsMyEmail@MyMail.com"
        let goal = CoreDataGoal(context: context!)
        let goalID = UUID()
        goal.id = goalID
        goal.title = "Turun 10 Kg dalam 10 Bulan"
        goal.isFinished = false
        goal.startDate = Calendar.current.date(byAdding: .day, value: -10, to: Date())!
        goal.duration = 5
        let plan1 = CoreDataPlan(context: context!)
        plan1.goalID = goalID
        plan1.title = "Olahraga"
        plan1.planColor = .colorOrange
        plan1.id = UUID()
        plan1.index = 0
        let action1 = CoreDataAction(context: context!)
        action1.id = UUID()
        action1.title = "Jogging"
        action1.repeats = .daily
        action1.startDate = Date()
        let action2 = CoreDataAction(context: context!)
        action2.id = UUID()
        action2.title = "Berenang"
        action2.repeats = .weekly
        action2.startDate = Date()

        user.addToGoals(goal)
        goal.addToPlans(plan1)
        plan1.addToActions([action1, action2])

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
