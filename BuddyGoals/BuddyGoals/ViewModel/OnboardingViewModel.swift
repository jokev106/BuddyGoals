//
//  OnboardingViewModel.swift
//  BuddyGoals
//
//  Created by Terrence Pramono on 22/07/22.
//

import Foundation
import CoreData
import SwiftUI

class OnboardingViewModel : ObservableObject {
    
    var context : NSManagedObjectContext?
    var user : CoreDataUser?
    var goal : CoreDataGoal?
    var plan : CoreDataPlan?
    
    func setup(context:NSManagedObjectContext) {
        self.context = context
    }
    
    func addEmptyUser() {
        let newUser = CoreDataUser(context: context!)
        newUser.id = UUID()
        let number = Int.random(in: 1000..<10000)
        newUser.name = "My Name"
        newUser.email = "User \(number)"
        
        save()
    }
    
    func addNewUser(name : String, username : String) {
        let newUser = CoreDataUser(context: context!)
        newUser.id = UUID()
        newUser.name = name
        newUser.email = username
        
        self.user = newUser
        save()
    }
    
    func addNewGoal(title : String) {
        let newGoal = CoreDataGoal(context: context!)
        newGoal.id = UUID()
        newGoal.isFinished = false
        newGoal.title = title
        newGoal.user = self.user
        
        self.goal = newGoal
        
        save()
    }
    
    func addNewPlan(title : String) {
        let newPlan = CoreDataPlan(context: context!)
        newPlan.id = UUID()
        newPlan.title = title
        newPlan.planColor = .colorBlue
        newPlan.goalID = self.goal?.id
        
        self.goal?.addToPlans(newPlan)
        
        self.plan = newPlan
        
        save()
    }
    
    func addNewAction(title : String) {
        let newAction = CoreDataAction(context: context!)
        newAction.id = UUID()
        newAction.title = title
        newAction.plan = self.plan
        newAction.startDate = Date()
        newAction.repeats = .never
        
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
