//
//  CoreDataPartner+CoreDataProperties.swift
//  BuddyGoals
//
//  Created by Terrence Pramono on 16/07/22.
//
//

import Foundation
import CoreData


extension CoreDataPartner {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataPartner> {
        return NSFetchRequest<CoreDataPartner>(entityName: "CoreDataPartner")
    }

    @NSManaged public var users: NSSet?

}

// MARK: Generated accessors for users
extension CoreDataPartner {

    @objc(addUsersObject:)
    @NSManaged public func addToUsers(_ value: CoreDataUser)

    @objc(removeUsersObject:)
    @NSManaged public func removeFromUsers(_ value: CoreDataUser)

    @objc(addUsers:)
    @NSManaged public func addToUsers(_ values: NSSet)

    @objc(removeUsers:)
    @NSManaged public func removeFromUsers(_ values: NSSet)

}

extension CoreDataPartner : Identifiable {

}
