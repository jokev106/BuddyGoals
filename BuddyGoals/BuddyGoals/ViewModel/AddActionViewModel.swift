//
//  AddActionViewModel.swift
//  BuddyGoals
//
//  Created by Terrence Pramono on 22/07/22.
//

import Foundation
import CoreData

class AddActionViewModel : ObservableObject {
    @Published var actionTitle : String = ""
    @Published var startDate : Date = Date()
    @Published var repeats : String = "Never"
    
    
    var context : NSManagedObjectContext?
    var coreDataController : CoreDataController?
    
    func setup(context: NSManagedObjectContext) {
        self.context = context
        coreDataController = CoreDataController(context: context)
    }
    
    func addAction(plan : CoreDataPlan) {
        let newAction = CoreDataAction(context: context!)
        newAction.id = UUID()
        newAction.title = actionTitle
        newAction.startDate = startDate
        newAction.repeats = RepeatAction(rawValue: repeats)!
        newAction.plan = plan
        
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
