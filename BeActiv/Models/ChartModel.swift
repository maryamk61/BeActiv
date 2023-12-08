//
//  ChartModel.swift
//  BeActiv
//
//  Created by Maryam Kaveh on 7/24/1402 AP.
//

import Foundation

struct ChartModel {
    let id: String
    let values: [Double]
    let labels: [String]
    let xAxisLabels: [String]
    
    static var mockChart: ChartModel {
        ChartModel(id:"stepCount", values: [824, 649, 1223, 2809, 450, 1402, 2026], labels: ["824 count", "649 count", "1223 count", "2809 count", "450 count","1402 count", "2026 count"], xAxisLabels: ["sat", "sun", "mon", "tue", "wed", "thu", "fri"])
    }
    
    static func getChartTitle(type: String) -> String {
        switch type {
        case "stepCount":
            return "Steps Count"
        case "activeEnergyBurned":
            return "Active Burned Calories"
        case "appleExerciseTime":
            return "Exercise Time"
        case "appleStandTime":
            return "Stand Time"
        case "distanceWalkingRunning" :
            return "Distance Walking/Running"
        default:
            return ""
        }
    }
}
