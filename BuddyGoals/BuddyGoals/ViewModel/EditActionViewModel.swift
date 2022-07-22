//
//  ActionViewModel.swift
//  BuddyGoals
//
//  Created by Terrence Pramono on 21/07/22.
//

import Foundation
import CoreData
import UIKit

class EditActionViewModel : ObservableObject {
    
    @Published var actionTitle : String = ""
    @Published var startDate : Date = Date()
    @Published var repeats : String = ""
    @Published var proofImage : UIImage = UIImage()
    
    
    var context : NSManagedObjectContext?
    var coreDataController : CoreDataController?
    
    // initial setup
    func setup(context: NSManagedObjectContext) {
        self.context = context
        coreDataController = CoreDataController(context: context)
    }
    
    // add new action
    
    
    // fill and update values for published properties
    func fillProperties(actionID:UUID) {
        let action = coreDataController?.selectOneWhereCoreData(entityName: "CoreDataAction", toPredicate: "id", predicateValue: "\(actionID)").first as! CoreDataAction
        actionTitle = action.wrappedTitle
        startDate = action.wrappedDate
        self.repeats = action.repeats.rawValue
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
    
    func submitProof(actionID : UUID) {
        let action = coreDataController?.selectOneWhereCoreData(entityName: "CoreDataAction", toPredicate: "id", predicateValue: "\(actionID)").first as! CoreDataAction
        let actionRecord = CoreDataActionRecord(context: context!)
        actionRecord.id = UUID()
        actionRecord.dateSubmitted = Date()
        actionRecord.proofImage = proofImage.pngData()
        action.addToRecords(actionRecord)
        
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
