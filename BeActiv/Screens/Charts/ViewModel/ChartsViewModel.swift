//
//  ChartsViewModel.swift
//  BeActiv
//
//  Created by Maryam Kaveh on 8/2/1402 AP.
//

import Foundation
import HealthKit

@MainActor
class ChartViewModel: ObservableObject {
    private var manager: HealthKitManager = HealthKitManager()
    @Published var statsCollections: [String: [StatusModel]] = [:]
    
    static let dateFormatterAxisLabel: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter
    }()
    
    init() {
    }
    
    func getAllStats(startDate: Date) async -> Void {
        let results = await manager.requestAllHealthInfo(startDate: startDate)
        DispatchQueue.main.async {
            self.statsCollections = results
        }
       
    }
}

enum ActivityTitle: String {
    case stepCount = "Step Count"
    case activeEnergyBurned = "Active Burned Calories"
    case appleExerciseTime = "Exercise Time"
    case distanceWalkingRunning = "Distance Walking/Running"
    case appleStandTime = "Stand Time"
}
