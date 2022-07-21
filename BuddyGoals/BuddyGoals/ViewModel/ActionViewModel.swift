//
//  ActionViewModel.swift
//  BuddyGoals
//
//  Created by Terrence Pramono on 21/07/22.
//

import Foundation
import CoreData

class ActionViewModel : ObservableObject {
    
    @Published var actionTitle : String = ""
    @Published var startDate : Date = Date()
    @Published var repeats : String = ""
    
    
    var context : NSManagedObjectContext?
    var coreDataController : CoreDataController?
    
    // initial setup
    func setup(context: NSManagedObjectContext) {
        self.context = context
        coreDataController = CoreDataController(context: context)
    }
    
    // add new action
    func addAction(plan : CoreDataPlan) {
        let newAction = CoreDataAction(context: context!)
        newAction.id = UUID()
        newAction.title = actionTitle
        newAction.startDate = startDate
        newAction.repeats = RepeatAction(rawValue: repeats)!
        newAction.plan = plan
        
        save()
    }
    
    // fill and update values for published properties
    func fillProperties(title : String, date : Date, repeats: String) {
        actionTitle = title
        startDate = date
        self.repeats = repeats
    }
    
    // edit action
    func editAction(action : CoreDataAction) {
        action.title = actionTitle
        action.startDate = startDate
        action.repeats = RepeatAction(rawValue: repeats)!
    }
    
    // sacve to core data
    func save() {
        do {
            try context?.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error \(error)")
        }
    }
    
    
    
}
