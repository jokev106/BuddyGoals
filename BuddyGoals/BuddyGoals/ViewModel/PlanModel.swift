//
//  PlanModel.swift
//  BuddyGoals
//
//  Created by Jonathan Kevin on 14/07/22.
//

import Foundation
import Combine
import SwiftUI

class PlanModel: ObservableObject {
    @Published var planTitle : String = ""
//    @Published var colorPlan : String = ""
    @Published var plans : [Plan] = []
    
    func onAdd(plan: String, color: String) {
        plans.append(Plan(planTitle: plan))
        self.planTitle = ""
//        self.colorPlan = ""
    }
    
    func onDelete(offset: IndexSet) {
        plans.remove(atOffsets: offset)
    }
    
    func onMove(source: IndexSet, destination: Int){
        plans.move(fromOffsets: source, toOffset: destination)
    }
 
    func onUpdate(index: Int, plan: String) {
        plans[index].planTitle = planTitle
//        plans[index].colorPlan = colorPlan
    }
}
