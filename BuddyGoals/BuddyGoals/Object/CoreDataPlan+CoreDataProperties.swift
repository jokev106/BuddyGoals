//
//  CoreDataPlan+CoreDataProperties.swift
//  BuddyGoals
//
//  Created by Terrence Pramono on 16/07/22.
//
//

import Foundation
import CoreData
import SwiftUI


extension CoreDataPlan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataPlan> {
        return NSFetchRequest<CoreDataPlan>(entityName: "CoreDataPlan")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var goal: CoreDataGoal?
    @NSManaged public var actions: NSSet?
    @NSManaged public var goalID : UUID?
    
    @NSManaged public var colorName : String
    
    var planColor : PlanColor {
        get {
            return PlanColor(rawValue: self.colorName)!
        }
        set {
            self.colorName = newValue.rawValue
        }
    }

}

// MARK: Generated accessors for actions
extension CoreDataPlan {

    @objc(addActionsObject:)
    @NSManaged public func addToActions(_ value: CoreDataAction)

    @objc(removeActionsObject:)
    @NSManaged public func removeFromActions(_ value: CoreDataAction)

    @objc(addActions:)
    @NSManaged public func addToActions(_ values: NSSet)

    @objc(removeActions:)
    @NSManaged public func removeFromActions(_ values: NSSet)

}

extension CoreDataPlan : Identifiable {
    var wrappedTitle : String {
        return title ?? "Unknown Plan"
    }
    
    var wrappedActions : [CoreDataAction] {
        let actionSet = actions as? Set<CoreDataAction> ?? []
        let sortedAction = actionSet.sorted { $0.wrappedTitle < $1.wrappedTitle }
        return sortedAction
    }
}

enum PlanColor : String{
    case colorBlue = "blue"
    case colorGreen = "green"
    case colorOrange = "orange"
    case colorPurple = "purple"
    case colorRed = "red"
    
    var colorValue : Color {
        switch self {
        case .colorBlue :
            return blue
        case .colorGreen:
            return green
        case .colorOrange :
            return orange
        case .colorPurple :
            return purple
        case .colorRed :
            // Not fixed yet
            return red900
        }
    }
}
