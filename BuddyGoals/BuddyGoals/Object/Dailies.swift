//
//  Dailies.swift
//  BuddyGoals
//
//  Created by Terrence Pramono on 25/06/22.
//

import Foundation

class Dailies : ObservableObject {
    var date : Date = Date.now
    @Published var todaysPlanAction : [PlanClass : [Actionable]] = [:]
    @Published var goal = GoalClass(title: "Turun 10 Kg dalam 10 Bulan", duration: 5, startDate: Calendar.current.date(byAdding: .day, value: -10, to: Date())!, rank: .medium, plans: [
        PlanClass(title: "Olahraga", actions: [
            Actionable(action: "Jogging tiap Pagi", time: Date(), place: "Kompleks", startDate: Date.now, repeats: .daily, difficulty: .medium),
            Actionable(action: "Push-up 100x", time: Date(), place: "Rumah", startDate: Date.now, repeats: .weekdays, difficulty: .hard),
            Actionable(action: "Renang", time: Date(), place: "Kolam", startDate: Date.now, repeats: .weekends, difficulty: .easy)
        ]),
        PlanClass(title: "Makan Sehat", actions: [
            Actionable(action: "Sarapan Salad", time: Date(), place: "Rumah", startDate: Date.now, repeats: .weekdays, difficulty: .trivial),
            Actionable(action: "Makan buah tiap pagi", time: Date(), place: "Rumah", startDate: Date.now, repeats: .daily, difficulty: .trivial)
        ])
    ])
    
    
    init() {
        getTodaysPlanAndAction()
    }
    

    func getTodaysPlanAndAction() {
        self.todaysPlanAction.removeAll()
        for plan in goal.plans {
            let temporaryAction = plan.actions.filter({!$0.isDoneToday && !$0.isDeleted})
            self.todaysPlanAction[plan] = temporaryAction
        }
    }
    
    func updateAction(planId:UUID, actionId:UUID, action : String, time : Date, place : String, startDate : Date, repeats : RepeatAction, difficulty : Rank) {
        var targetPlan = self.goal.plans.filter({$0.id == planId})[0]
        var targetAction = targetPlan.actions.filter({$0.id == actionId})[0]
        let targetIndex = targetPlan.actions.firstIndex(where: {$0 === targetAction})!
//        targetAction.action = action
//        targetAction.time = time
//        targetAction.place = place
//        if let changedAction = action {
////            self.goal.plans.filter({$0.id == planId})[0].actions.filter({$0.id == actionId})[0].action = changedAction
//            targetAction.action = changedAction
//        }
//        if let changedTime = time {
//            targetAction.time = changedTime
//        }
//        if let changedPlace = place {
//            targetAction.place = changedPlace
//        }
//        if let changedStartDate = startDate {
//            targetAction.startDate = changedStartDate
//        }
//        if let changedRepeat = repeats {
//            targetAction.repeats = changedRepeat
//        }
//        if let changedDifficulty = difficulty {
//            targetAction.difficulty = changedDifficulty
//        }
        targetPlan.actions = targetPlan.actions.filter({$0.id != targetAction.id})
        targetPlan.actions.insert(Actionable(action: action, time: time, place: place, startDate: startDate, repeats: repeats, difficulty: difficulty), at: targetIndex)
//        targetPlan.addNewAction(action: "Bla", time: Date(), place: "", startDate: Date(), repeats: .daily, difficulty: .expert)
//        targetPlan.actions = targetPlan.actions.filter({$0.action != "Bla"})
        self.getTodaysPlanAndAction()
//        var targetDailies = self.todaysPlanAction.filter({$0.key.id == planId})[0]
//        targetDailies.value.append(Actionable(action: "Bla", time: Date(), place: "", startDate: Date(), repeats: .daily, difficulty: .expert))
        let _ = print(targetPlan.actions.count)
//        targetDailies.value = targetDailies.value.filter{$0.action != "Bla"}
    }
    
    func addNewPlan(title: String) {
        self.goal.addNewPlan(title: title)
//        self.todaysPlanAction[PlanClass(title: "Bla")] = []
//        self.todaysPlanAction.filter({$0.key.title != "Bla"})
        self.getTodaysPlanAndAction()
    }
    
    func addNewAction(planTitle : String = "Olahraga", action : String, time : Date, place : String, startDate : Date, repeats : RepeatAction, difficulty : Rank) {
        var targetPlan = self.goal.plans.filter({$0.title == planTitle})[0]
        targetPlan.addNewAction(action: action, time: time, place: place, startDate: startDate, repeats: repeats, difficulty: difficulty)
        self.getTodaysPlanAndAction()
    }
}
