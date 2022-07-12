//
//  User.swift
//  BuddyGoals
//
//  Created by Terrence Pramono on 24/06/22.
//

import Foundation

class UserClass {
    
    let userId : String
    var userName : String
    var name : String
    var goals : [GoalClass] = []
    //Progress ??
    
    init(userName : String, name : String) {
        self.userId = "U001"
        self.userName = userName
        self.name = name
    }
    
    func addNewGoal(title : String, duration : Int, startDate : Date, rank : Rank) {
        self.goals.append(GoalClass(title: title, duration: duration, startDate: startDate, rank: rank))
    }
    
    
}
