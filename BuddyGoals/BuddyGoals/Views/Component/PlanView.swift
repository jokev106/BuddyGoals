//
//  PlanView.swift
//  BuddyGoals
//
//  Created by Terrence Pramono on 19/07/22.
//

import SwiftUI

struct PlanView: View {
    
    let plan : CoreDataPlan
    
    var body: some View {
        VStack(spacing:-10){
            HStack{
                Text(plan.wrappedTitle)
                    .foregroundColor(.gray)
                    .font(.system(size: 22.5))
                    .bold()
                    .padding()
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .padding()
                        .foregroundColor(whiteDark)
                }) //Button
            }
            
            //Card
            ForEach (plan.wrappedActions) { action in
                CardHomeView(colorCard: plan.planColor.colorValue, milestone: action.wrappedTitle, destinationCard: "")
            }
//            CardHomeView(colorCard: orange, milestone: "Plank for 3 minutes", destinationCard: "")
//            CardHomeView(colorCard: blue, milestone: "Sit up 10 times", destinationCard: "")
//            CardHomeView(colorCard: white, milestone: "Vertical Jumps for 3 minutes", destinationCard: "")
//            CardHomeView(colorCard: white, milestone: "Try Something", destinationCard: "")
//            CardHomeView(colorCard: white, milestone: "Try Something", destinationCard: "")
//            CardHomeView(colorCard: white, milestone: "Try Something", destinationCard: "")
            //Close of Card
        }
    }
}


