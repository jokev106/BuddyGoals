//
//  Plan.swift
//  BuddyGoals
//
//  Created by Terrence Pramono on 24/06/22.
//

import Foundation

class PlanClass : Hashable, Equatable, Identifiable {
    
    
    
    // ID = GoalID + PlanID
    let id : UUID
    var title : String
    var actions : [Actionable] = []
    var isDeleted : Bool = false
    
    
    
    init(title : String, actions : [Actionable] = []) {
        self.id = UUID()
        self.title = title
        self.actions = actions
    }
    
    // Protocol Equatable
    static func == (lhs: PlanClass, rhs: PlanClass) -> Bool {
        return lhs.id == rhs.id
    }
    
    // Custom hash function untuk protocol Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func addNewAction(action : String, time : Date, place : String, startDate : Date, repeats : RepeatAction, difficulty : Rank) {
        self.actions.append(Actionable(action: action, time: time, place: place, startDate: startDate, repeats: repeats, difficulty: difficulty))
    }
    
    
    func removeAction(_ id : UUID) {
        var removedAction = self.actions.filter {$0.id == id}[0]
        removedAction.isDeleted = true
    }
    
    
    
}
