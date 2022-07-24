//
//  RepeatAction.swift
//  BuddyGoals
//
//  Created by Terrence Pramono on 24/06/22.
//

import Foundation

enum RepeatAction : String {
    case never = "Never"
    case daily = "Daily"
    case weekdays = "Weekdays"
    case weekends = "Weekends"
    case weekly = "Weekly"
    case biweekly = "Biweekly"
    case monthly = "Monthly"
    case every_3_months = "Every 3 Months"
    case every_6_months = "Every 6 Months"
    case yearly = "Yearly"
    
    var repeatComponent : DateComponents? {
        var component = DateComponents()
        switch self {
        case .never:
            component.day = 0
        case .daily:
            component.day = 1
        case .weekdays:
            return nil
        case .weekends:
            return nil
        case .weekly:
            component.day = 7
        case .biweekly:
            component.day = 14
        case .monthly:
            component.month = 1
        case .every_3_months:
            component.month = 3
        case .every_6_months:
            component.month = 6
        case .yearly:
            component.year = 1
        }
        return component
    }
    
}
