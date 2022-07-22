//
//  CoreDataAction+CoreDataProperties.swift
//  BuddyGoals
//
//  Created by Terrence Pramono on 16/07/22.
//
//

import Foundation
import CoreData


extension CoreDataAction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataAction> {
        return NSFetchRequest<CoreDataAction>(entityName: "CoreDataAction")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var plan: CoreDataPlan?
    @NSManaged public var records: NSSet?
    
    @NSManaged public var repeatValue : String

    var repeats : RepeatAction {
        get {
            return RepeatAction(rawValue: repeatValue)!
        }
        set {
            self.repeatValue = newValue.rawValue
        }
    }
}

// MARK: Generated accessors for records
extension CoreDataAction {

    @objc(addRecordsObject:)
    @NSManaged public func addToRecords(_ value: CoreDataActionRecord)

    @objc(removeRecordsObject:)
    @NSManaged public func removeFromRecords(_ value: CoreDataActionRecord)

    @objc(addRecords:)
    @NSManaged public func addToRecords(_ values: NSSet)

    @objc(removeRecords:)
    @NSManaged public func removeFromRecords(_ values: NSSet)

}

extension CoreDataAction : Identifiable {
    var wrappedTitle : String {
        return title ?? "Unknown Action"
    }
    
    var wrappedDate : Date {
        return startDate ?? Date()
    }
    
    var wrappedRecords : [CoreDataActionRecord] {
        let recordsSet = records as? Set<CoreDataActionRecord> ?? []
        let sortedRecords = recordsSet.sorted { $0.wrappedDate <= $1.wrappedDate }
        
        return sortedRecords
    }
    
    var isDoneToday : Bool {
        let actionRecord = wrappedRecords.filter {
            Calendar.current.dateComponents([.day], from: $0.wrappedDate, to: Date()).day == 0
        }
        if actionRecord.count == 0 {
            return false
        } else {
            return true
        }
    }
}
