//
//  CoreDataActionRecord+CoreDataProperties.swift
//  BuddyGoals
//
//  Created by Terrence Pramono on 16/07/22.
//
//

import Foundation
import CoreData


extension CoreDataActionRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataActionRecord> {
        return NSFetchRequest<CoreDataActionRecord>(entityName: "CoreDataActionRecord")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var dateSubmitted: Date?
    @NSManaged public var proofImage: Data?
    @NSManaged public var action: CoreDataAction?
    
    @NSManaged public var statusValue : String
    
    var status : ActionStatus {
        get {
            return ActionStatus(rawValue: self.statusValue)!
        }
        
        set {
            self.statusValue = newValue.rawValue
        }
    }
}

extension CoreDataActionRecord : Identifiable {
    var wrappedDate : Date {
        return dateSubmitted ?? Date()
    }
}

enum ActionStatus : String {
    case needApproval = "Need Approval"
    case waitingSubmission = "Waiting Submission"
    case approved = "Approved"
}
