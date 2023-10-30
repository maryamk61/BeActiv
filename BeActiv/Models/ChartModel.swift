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
        ChartModel(id:"stepCount", values: [2824, 6649, 1223, 7809, 450, 3402, 12026], labels: ["2824 count", "6649 count", "7809 count", "450 count", "342 count","5974 count", "1226 count"], xAxisLabels: ["sat", "sun", "mon", "tue", "wed", "thu", "fri"])
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
