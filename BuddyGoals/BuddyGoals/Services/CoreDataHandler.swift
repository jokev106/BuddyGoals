//
//  CoreDataController.swift
//  NC1_William_Expense_Tracker
//
//  Created by William on 28/04/22.
//

import Foundation
import CoreData

class CoreDataController {
    /// Get context for context to be used in this Controller.
    /// To get context, create PersistenceController class, then create NSPersistentCloudKitContainer with
    /// the parameter "name".
    /// Fill the name parameter with name of your CoreData file (not entity or attributes).
    /// After creating PersistenceController, call it in your @main app, then:
    ///  - Step 1: Create a variable (let prefered because its immutable) that holds the PersistenceController shared attribute. Ex: let persistence = PersistenceController.shared
    ///  - Step 2: At your body Scene, when you call your view, make sure to create an environment of your persistence's container viewContext attribute to get the context.
    ///  - Step 3: At your view that you want to use CoreData and CoreDataController, call an environmnet variable holding the context. Ex: @Environment(\.managedObjectContext) var context
    ///  - Step 4: Create a variable holding CoreDataController and pass context as parameter, then you can use the controller to access your core data.
    var context: NSManagedObjectContext?
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    /// Insert data passed into core data
    ///
    /// - Parameters:
    ///   - entityName: the name of your entity (table in SQL)
    ///   - key: column name of the item you want to insert
    ///   - value: the value for the column (according to the sequence of key parameter) to be inserted in
    ///   the same row
    func insertToCoreData(entityName: String, key: [String], value: [String]) {
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context!) else { return }
        let entityData = NSManagedObject(entity: entity, insertInto: context)
        for index in 0...value.count-1 {
            entityData.setValue(value[index], forKey: key[index])
        }
        
        do {
            try context!.save()
        } catch {
            print("Error saving data")
        }
    }
    
    /// Select all data (all columns and rows) from the entity name passed
    ///
    /// - Parameters:
    ///   - entityName: the name of your entity (table in SQL)
    func selectAllCoreData(entityName: String) -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let result = try! context!.fetch(fetchRequest) as! [NSManagedObject]
        return result
    }
    
    /// Select data from core data using only one conditional
    ///
    /// - Parameters:
    ///   - entityName: the name of your entity (table in SQL)
    ///   - toPredicate: the name of the column that you want to predicate (where in SQL)
    ///   - predicateValue: the name of the value that you want to find
    func selectOneWhereCoreData(entityName: String, toPredicate: String, predicateValue: String) -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let predicateCoreData = NSPredicate(format: "\(toPredicate) = %@", predicateValue)
        fetchRequest.predicate = predicateCoreData
        let result = try! context!.fetch(fetchRequest) as! [NSManagedObject]

        return result
    }
    
    /// Select data from core data using more than one conditional with AND
    ///
    /// - Parameters:
    ///   - entityName: the name of your entity (table in SQL)
    ///   - toPredicate: multiple name of the column that you want to predicate (where in SQL)
    ///   - predicateValue: multiple name of the value that you want to find
    func selectMultipleWhereAndCoreData(entityName: String, toPredicate: [String], predicateValue: [String]) -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var predicateCoreData: [NSPredicate] = []
        for index in 0...toPredicate.count-1 {
            predicateCoreData.append(NSPredicate(format: "\(toPredicate[index]) = %@", predicateValue[index]))
        }
        let predicateCompound = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: predicateCoreData)

        fetchRequest.predicate = predicateCompound
        let result = try! context!.fetch(fetchRequest) as! [NSManagedObject]
        
        return result
    }

    /// Select data from core data using more than one conditional with OR
    ///
    /// - Parameters:
    ///   - entityName: the name of your entity (table in SQL)
    ///   - toPredicate: multiple name of the column that you want to predicate (where in SQL)
    ///   - predicateValue: multiple name of the value that you want to find
    func selectMultipleWhereOrCoreData(entityName: String, toPredicate: [String], predicateValue: [String]) -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var predicateCoreData: [NSPredicate] = []
        for index in 0...toPredicate.count-1 {
            predicateCoreData.append(NSPredicate(format: "\(toPredicate[index]) = %@", predicateValue[index]))
        }
        let predicateCompound = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.or, subpredicates: predicateCoreData)

        fetchRequest.predicate = predicateCompound
        let result = try! context!.fetch(fetchRequest) as! [NSManagedObject]
        
        return result
    }
    
    /// Update core data using more than one conditional with AND
    ///
    /// - Parameters:
    ///   - entityName: the name of your entity (table in SQL)
    ///   - toPredicate: multiple name of the column that you want to predicate (where in SQL)
    ///   - predicateValue: multiple name of the value that you want to find
    ///   - valueToChange: column name of the value that wants to be changed
    ///   - value: value that wants to be used to replace the existing value.
    func updateMultipleWhereAndCoreData(entityName: String, toPredicate: [String], predicateValue: [String], valueToChange: String, value: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var predicateCoreData: [NSPredicate] = []
        for index in 0...toPredicate.count-1 {
            predicateCoreData.append(NSPredicate(format: "\(toPredicate[index]) = %@", predicateValue[index]))
        }
        let predicateCompound = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: predicateCoreData)

        fetchRequest.predicate = predicateCompound
        let result = try! context!.fetch(fetchRequest) as! [NSManagedObject]
        if result.count != 0 {
            result.first?.setValue(value, forKey: valueToChange)
        }
    }
    
    /// Delete data from core data with AND
    ///
    /// - Parameters:
    ///   - entityName: the name of your entity (table in SQL)
    ///   - toPredicate: multiple name of the column that you want to predicate (where in SQL)
    ///   - predicateValue: multiple name of the value that you want to find
    func deleteData(entityName: String, toPredicate: [String], predicateValue: [String]) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var predicateCoreData: [NSPredicate] = []
        for index in 0...toPredicate.count-1 {
            predicateCoreData.append(NSPredicate(format: "\(toPredicate[index]) = %@", predicateValue[index]))
        }
        let predicateCompound = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: predicateCoreData)

        fetchRequest.predicate = predicateCompound
        let result = try! context!.fetch(fetchRequest)
        for items in result {
            context!.delete(items as! NSManagedObject)
        }
        
        do {
            try context!.save()
        } catch {
            print("Failed to delete data")
        }
    }
}
