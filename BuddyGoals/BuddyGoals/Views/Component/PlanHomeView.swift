//
//  PlanHomeView.swift
//  BuddyGoals
//
//  Created by Terrence Pramono on 29/06/22.
//

import SwiftUI

struct PlanHomeView: View {
    
    var plan : PlanClass
    var planActions : [Actionable]
    
    var body: some View {
        VStack(spacing:-10){
            HStack{
                Text(plan.title)
                    .foregroundColor(.gray)
                    .font(.system(size: 22.5))
                    .bold()
                    .padding()
                Spacer()
            }
            //Card
            ForEach(planActions) { action in
                
                NavigationLink(destination: AddActionView(action : action, planId: plan.id), label: {
                    
                    let imageColor : Color = getImageNameColor(action: action)
                    
//                    CardHomeView(colorCard: imageColor, milestone: action.action, destinationCard: "")
                    CardHomeView(colorCard: imageColor, milestone: action.action, destinationCard: "")
                })
//                Text(action.action)
            }
            //Close of Card
        }
    }
    func getImageNameColor(action:Actionable) -> Color {
        switch action.difficulty {
        case .trivial:
            return white
        case .easy:
            return white
        case .medium:
            return blue
        case .hard:
            return purple
        case .expert:
            return orange
        }
    }
}

struct PlanHomeView_Previews: PreviewProvider {
    static var previews: some View {
        PlanHomeView(plan: PlanClass(title: "NN", actions: []), planActions: [Actionable(action: "Main", time: Date(), place: "Rumah", startDate: Date(), repeats: .biweekly, difficulty: .expert)])
    }
}
