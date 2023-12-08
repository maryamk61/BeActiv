//
//  ActivityModel.swift
//  BeActiv
//
//  Created by Maryam Kaveh on 7/23/1402 AP.
//

import Foundation
import HealthKit

struct ActivityModel {
    enum ActivityTitle: String {
        case stepCount = "Step Count"
        case activeEnergyBurned = "Active Burned Calories"
        case appleExerciseTime = "Exercise Time"
        case distanceWalkingRunning = "Distance Walking/Running"
        case appleStandTime = "Stand Time"
    }
    
    enum ActivityImage: String {
        case stepCount = "shoeprints.fill"
        case activeEnergyBurned = "flame"
        case appleExerciseTime = "figure.strengthtraining.traditional"
        case distanceWalkingRunning = "figure.run"
        case appleStandTime = "figure.stand"
    }

    var uuid = UUID().uuidString
    var id: String
    var title: String {
        switch id {
        case "stepCount" :
            return ActivityTitle.stepCount.rawValue
        case "activeEnergyBurned":
            return ActivityTitle.activeEnergyBurned.rawValue
        case "appleExerciseTime":
            return ActivityTitle.appleExerciseTime.rawValue
        case "distanceWalkingRunning":
            return ActivityTitle.distanceWalkingRunning.rawValue
        case "appleStandTime":
            return ActivityTitle.appleStandTime.rawValue
        default:
            return ActivityTitle.appleStandTime.rawValue
        }
    }
    var image: String {
        switch id {
        case "stepCount" :
            return ActivityImage.stepCount.rawValue
        case "activeEnergyBurned":
            return ActivityImage.activeEnergyBurned.rawValue
        case "appleExerciseTime":
            return ActivityImage.appleExerciseTime.rawValue
        case "distanceWalkingRunning":
            return ActivityImage.distanceWalkingRunning.rawValue
        case "appleStandTime":
            return ActivityImage.appleStandTime.rawValue
        default:
            return ActivityImage.appleStandTime.rawValue
        }
    }
    
    var todayValue: Double
    var todayDesc: String
    var weeklyGoal: Double
    
    static var allActivities: [ActivityModel] {
        return [
            ActivityModel(id: "stepCount", todayValue: 950, todayDesc: "950 count", weeklyGoal: 1500),
            ActivityModel(id: "activeEnergyBurned", todayValue: 400, todayDesc: "400 kcal", weeklyGoal: 500),
            ActivityModel(id: "appleExerciseTime", todayValue: 30, todayDesc: "30 minutes", weeklyGoal: 45),
            ActivityModel(id: "distanceWalkingRunning", todayValue: 1.0, todayDesc: "1.0 Mile", weeklyGoal: 1.3),
            ActivityModel(id: "appleStandTime", todayValue: 128, todayDesc: "128 minutes", weeklyGoal: 200)
        ]
    }
    
    static var mockActivity: ActivityModel {
        ActivityModel(id: "appleStandTime", todayValue: 168, todayDesc: "168 minutes", weeklyGoal: 200)
    }
    
}

  
