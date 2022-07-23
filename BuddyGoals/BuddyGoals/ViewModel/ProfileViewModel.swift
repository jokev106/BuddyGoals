//
//  ProfileViewModel.swift
//  BuddyGoals
//
//  Created by Terrence Pramono on 20/07/22.
//

import Foundation
import CoreData
import SwiftUI

class ProfileViewModel : ObservableObject {
    
    @Published var name : String = ""
    @Published var currentGoal : String = ""
    @Published var scheduleStart : Date = Date()
    @Published var duration : Int = 0
    @Published var imageSelected = UIImage()
    
    
    
    var context : NSManagedObjectContext?
    var user : CoreDataUser?
    var coreDataController : CoreDataController?
    
    
    // initial setup
    func setup(context : NSManagedObjectContext, userID : UUID?) {
        self.context = context
        self.coreDataController = CoreDataController(context: context)
        if userID != nil {
            getUser(id: userID)
        }
        else{
            fillProperties()
        }
    }
    
    // query user info
    func getUser(id : UUID?) {
        let tempID = id ?? self.user!.id!
        self.user = (coreDataController?.selectOneWhereCoreData(entityName: "CoreDataUser", toPredicate: "id", predicateValue: "\(tempID)").first! as! CoreDataUser)
        fillProperties()
    }
    
    // fill and update published properties
    func fillProperties() {
        name = self.user?.wrappedName ?? "Unknown User"
        imageSelected = self.user?.wrappedPicture ?? UIImage(named: "Gusde-Emot")!
        let tempGoal = self.user?.wrappedGoals.filter { $0.isFinished == false }.first
        currentGoal = tempGoal?.wrappedTitle ?? "No Goal Set Yet"
        scheduleStart = tempGoal?.startDate ?? Date()
        duration = tempGoal?.wrappedDuration ?? -1
    }
    
    // update user + goal
    func update() {
        user?.name = name
        user?.profilePicture = imageSelected.pngData()
        let tempGoal = self.user?.wrappedGoals.filter { $0.isFinished == false }.first
        if tempGoal != nil {
            tempGoal?.title = currentGoal
            tempGoal?.startDate = scheduleStart
            tempGoal?.duration = Int16(duration)
        } else {
            if currentGoal != "No Goal Set Yet" && duration > 0 {
                let newGoal = CoreDataGoal(context: context!)
                newGoal.id = UUID()
                newGoal.title = currentGoal
                newGoal.startDate = scheduleStart
                newGoal.duration = Int16(duration)
                
                newGoal.user = user
            }
        }
        
        save()
    }
    
    // finish goal
    func finishGoal() {
        let tempGoal = self.user?.wrappedGoals.filter { $0.isFinished == false }.first
        tempGoal?.isFinished = true
        
        save()
    }
    
    // save in core data
    func save() {
        do {
            try context?.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error \(error)")
        }
    }
}
