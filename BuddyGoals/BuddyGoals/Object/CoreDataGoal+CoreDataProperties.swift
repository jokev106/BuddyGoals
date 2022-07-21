//
//  CoreDataGoal+CoreDataProperties.swift
//  BuddyGoals
//
//  Created by Terrence Pramono on 16/07/22.
//
//

import Foundation
import CoreData


extension CoreDataGoal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataGoal> {
        return NSFetchRequest<CoreDataGoal>(entityName: "CoreDataGoal")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var duration: Int16
    @NSManaged public var isFinished: Bool
    @NSManaged public var user: CoreDataUser?
    @NSManaged public var plans: NSSet?
    

}

// MARK: Generated accessors for plans
extension CoreDataGoal {

    @objc(addPlansObject:)
    @NSManaged public func addToPlans(_ value: CoreDataPlan)

    @objc(removePlansObject:)
    @NSManaged public func removeFromPlans(_ value: CoreDataPlan)

    @objc(addPlans:)
    @NSManaged public func addToPlans(_ values: NSSet)

    @objc(removePlans:)
    @NSManaged public func removeFromPlans(_ values: NSSet)

}

extension CoreDataGoal : Identifiable {
    
    var wrappedTitle : String {
        return title ?? "Unknown Goal"
    }
    
    var wrappedDuration : Int {
        return Int(duration)
    }
    
    var wrappedPlans : [CoreDataPlan] {
        let planSet = plans as? Set<CoreDataPlan> ?? []
        let sortedPlan = planSet.sorted { $0.wrappedIndex <= $1.wrappedIndex }
        return sortedPlan
    }
}
