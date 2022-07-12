//
//  Goal.swift
//  BuddyGoals
//
//  Created by Terrence Pramono on 24/06/22.
//

import Foundation

class GoalClass : Identifiable {
    
    let id = UUID()
    var title : String
    var duration : Int // in weeks
    var startDate : Date
    var plans : [PlanClass] = []
    var rank : Rank
    var totalPoints : Int = 0
    var endDate : Date = Date.now
    var isDeleted : Bool = false
    
    init(title : String, duration : Int, startDate : Date, rank : Rank, plans : [PlanClass] = []) {
        
        self.title = title
        self.duration = duration
        self.startDate = startDate
        self.rank = rank
        self.plans = plans
        self.endDate = calculateEndDate()
    }
    
    
    
    private func calculateEndDate() -> Date {
        var dateComponent = DateComponents()
        
        dateComponent.day = 7 * duration
        let calculatedEndDate = Calendar.current.date(byAdding: dateComponent, to: self.startDate)
        return calculatedEndDate!
    }
    
    func calculateRemainingDays() -> Int {
        let diffSeconds = endDate.timeIntervalSinceReferenceDate - Date().timeIntervalSinceReferenceDate
        let diffDays = Int(diffSeconds / (60.0 * 60.0 * 24.0))
        return diffDays
    }
    
    func addNewPlan(title : String) {
        self.plans.append(PlanClass(title: title))
    }
    
    
    func removePlan(_ id : UUID) {
        var removedPlan = self.plans.filter {$0.id == id}[0]
        removedPlan.isDeleted = true
    }
    
}
