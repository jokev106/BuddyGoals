//
//  CoreDataUser+CoreDataProperties.swift
//  BuddyGoals
//
//  Created by Terrence Pramono on 16/07/22.
//
//

import Foundation
import CoreData


extension CoreDataUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataUser> {
        return NSFetchRequest<CoreDataUser>(entityName: "CoreDataUser")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var name: String?
    @NSManaged public var profilePicture: Data?
    @NSManaged public var isLoggedIn: Bool
    @NSManaged public var partners: NSSet?
    @NSManaged public var goals: NSSet?

}

// MARK: Generated accessors for partners
extension CoreDataUser {

    @objc(addPartnersObject:)
    @NSManaged public func addToPartners(_ value: CoreDataPartner)

    @objc(removePartnersObject:)
    @NSManaged public func removeFromPartners(_ value: CoreDataPartner)

    @objc(addPartners:)
    @NSManaged public func addToPartners(_ values: NSSet)

    @objc(removePartners:)
    @NSManaged public func removeFromPartners(_ values: NSSet)

}

// MARK: Generated accessors for goals
extension CoreDataUser {

    @objc(addGoalsObject:)
    @NSManaged public func addToGoals(_ value: CoreDataGoal)

    @objc(removeGoalsObject:)
    @NSManaged public func removeFromGoals(_ value: CoreDataGoal)

    @objc(addGoals:)
    @NSManaged public func addToGoals(_ values: NSSet)

    @objc(removeGoals:)
    @NSManaged public func removeFromGoals(_ values: NSSet)

}

extension CoreDataUser : Identifiable {
    
    public var wrappedName : String {
        return name ?? "Unknown User"
    }
    
    public var wrappedGoals : [CoreDataGoal] {
        let goalSet = goals as? Set<CoreDataGoal> ?? []
        let sortedGoal = goalSet.sorted { $0.wrappedTitle < $1.wrappedTitle }
        
        return sortedGoal
    }
}
