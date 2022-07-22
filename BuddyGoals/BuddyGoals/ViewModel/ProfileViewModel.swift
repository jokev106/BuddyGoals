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
    func setup(context : NSManagedObjectContext, userID : UUID) {
        self.context = context
        self.coreDataController = CoreDataController(context: context)
        getUser(id: userID)
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
        imageSelected = self.user?.wrappedPicture ?? UIImage()
        let tempGoal = self.user?.wrappedGoals.filter { $0.isFinished == false }[0]
        currentGoal = tempGoal!.wrappedTitle
        scheduleStart = tempGoal!.startDate!
        duration = tempGoal!.wrappedDuration
    }
    
    // update user + goal
    func update() {
        user?.name = name
        user?.profilePicture = imageSelected.pngData()
        let tempGoal = self.user?.wrappedGoals.filter { $0.isFinished == false }[0]
        tempGoal?.title = currentGoal
        tempGoal?.startDate = scheduleStart
        tempGoal?.duration = Int16(duration)
        
        save()
    }
    
    // finish goal
    func finishGoal() {
        let tempGoal = self.user?.wrappedGoals.filter { $0.isFinished == false }[0]
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
