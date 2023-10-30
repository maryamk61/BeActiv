//
//  HomeViewModel.swift
//  BeActiv
//
//  Created by Maryam Kaveh on 7/29/1402 AP.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var activities: [ActivityModel] = []
    private var manager : HealthKitManager = HealthKitManager()
    
    init()  {
        UserDefaults.standard.set(1000.0, forKey: "stepCount")
        UserDefaults.standard.set(500.0, forKey: "activeEnergyBurned")
        UserDefaults.standard.set(30.0, forKey: "appleExerciseTime")
        UserDefaults.standard.set(1.0, forKey: "distanceWalkingRunning")
    }

    func getTodayAllHealthInfo() async {
        let activities = await manager.requestTodayAllHealthInfo()
        DispatchQueue.main.async {
            self.activities = activities
        }
    }
}
