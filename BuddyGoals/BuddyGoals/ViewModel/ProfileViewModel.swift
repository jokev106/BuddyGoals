//
//  ProfileViewModel.swift
//  BuddyGoals
//
//  Created by Terrence Pramono on 20/07/22.
//

import Foundation
import CoreData

class ProfileViewModel : ObservableObject {
    
    @Published var name : String = ""
    @Published var currentGoal : String = ""
    @Published var scheduleStart : Date = Date()
    @Published var duration : Int = 0
    
    
    var context : NSManagedObjectContext?
    var user : CoreDataUser?
    var coreDataController : CoreDataController?
    
    func setup(context : NSManagedObjectContext, userID : UUID) {
        self.context = context
        self.coreDataController = CoreDataController(context: context)
        getUser(id: userID)
    }
    
    func getUser(id : UUID?) {
        let tempID = id ?? self.user!.id!
        self.user = (coreDataController?.selectOneWhereCoreData(entityName: "CoreDataUser", toPredicate: "id", predicateValue: "\(tempID)").first! as! CoreDataUser)
        fillProperties()
    }
    
    func fillProperties() {
        name = self.user?.wrappedName ?? "Unknown User"
        let tempGoal = self.user?.wrappedGoals.filter { $0.isFinished == false }[0]
        currentGoal = tempGoal!.wrappedTitle
        scheduleStart = tempGoal!.startDate!
        duration = tempGoal!.wrappedDuration
    }
    
    func update() {
        user?.name = name
        let tempGoal = self.user?.wrappedGoals.filter { $0.isFinished == false }[0]
        tempGoal?.title = currentGoal
        tempGoal?.startDate = scheduleStart
        tempGoal?.duration = Int16(duration)
        
        save()
    }
    
    func finishGoal() {
        let tempGoal = self.user?.wrappedGoals.filter { $0.isFinished == false }[0]
        tempGoal?.isFinished = true
        
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
