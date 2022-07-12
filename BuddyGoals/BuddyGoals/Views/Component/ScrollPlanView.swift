//
//  ScrollPlanView.swift
//  BuddyGoals
//
//  Created by Terrence Pramono on 29/06/22.
//

import SwiftUI

struct ScrollPlanView: View {
    
    @EnvironmentObject var activityToday : Dailies
    
    var body: some View {
        ScrollView {
            ForEach(Array(activityToday.todaysPlanAction.keys)) { key in
                PlanHomeView(plan: key, planActions: activityToday.todaysPlanAction[key]!)
//                ForEach(activityToday.todaysPlanAction[key]!) { action in
//                    Text(action.action)
//                }
            }
            
        }
    }
}

struct ScrollPlanView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollPlanView()
            .environmentObject(Dailies())
    }
}

