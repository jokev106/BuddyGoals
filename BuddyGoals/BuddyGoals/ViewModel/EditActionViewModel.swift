//
//  ActionViewModel.swift
//  BuddyGoals
//
//  Created by Terrence Pramono on 21/07/22.
//

import Foundation
import CoreData

class EditActionViewModel : ObservableObject {
    
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
    
    
    // fill and update values for published properties
    func fillProperties(title : String, date : Date, repeats: RepeatAction) {
        actionTitle = title
        startDate = date
        self.repeats = repeats.rawValue
    }
    
    // edit action
    func editAction(actionID : UUID) {
        let action = coreDataController?.selectOneWhereCoreData(entityName: "CoreDataAction", toPredicate: "id", predicateValue: "\(actionID)").first! as! CoreDataAction
        action.title = actionTitle
        action.startDate = startDate
        action.repeats = RepeatAction(rawValue: repeats)!
//        let plan = action.plan
//        let newDummyAction = CoreDataAction(context: context!)
//        newDummyAction.id = UUID()
//        newDummyAction.title = "Dummy"
//        plan?.addToActions(newDummyAction)
//        save()
//        plan?.removeFromActions(newDummyAction)
        save()
    }
    
    func removeDummyAction() {
        let dummyAction = coreDataController?.selectOneWhereCoreData(entityName: "CoreDataAction", toPredicate: "title", predicateValue: "Dummy").first! as! CoreDataAction
        let plan = dummyAction.plan
        plan?.removeFromActions(dummyAction)
        save()
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
