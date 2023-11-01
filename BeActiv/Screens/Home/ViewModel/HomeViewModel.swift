//
//  HomeViewModel.swift
//  BeActiv
//
//  Created by Maryam Kaveh on 7/29/1402 AP.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var activities: [ActivityModel] = []
    private var manager : HealthKitManager
    
    init(manager: HealthKitManager = HealthKitManager())  {
        if (UserDefaults.standard.object(forKey: "stepCount") == nil) {
            UserDefaults.standard.set(1000.0, forKey: "stepCount")
        }
        if (UserDefaults.standard.object(forKey: "activeEnergyBurned") == nil) {
            UserDefaults.standard.set(500.0, forKey: "activeEnergyBurned")
        }
        if (UserDefaults.standard.object(forKey: "appleExerciseTime") == nil) {
            UserDefaults.standard.set(30.0, forKey: "appleExerciseTime")
        }
        if (UserDefaults.standard.object(forKey: "distanceWalkingRunning") == nil) {
            UserDefaults.standard.set(1.0, forKey: "distanceWalkingRunning")
        }
                    
        self.manager = manager
        requestAuthorization()
    }

    func getTodayAllHealthInfo() {
        Task {
            let activities = await manager.requestTodayAllHealthInfo()
            DispatchQueue.main.async {
                self.activities = activities                
            }
        }
    }
    
    func requestAuthorization() {
        manager.requestAuthorization { success in
            if success {
                self.getTodayAllHealthInfo()
            }
        }
    }
}
