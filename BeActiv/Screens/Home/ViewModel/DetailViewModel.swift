//
//  DetailViewModel.swift
//  BeActiv
//
//  Created by Maryam Kaveh on 7/25/1402 AP.
//

import Foundation
import HealthKit

@MainActor
final class DetailViewModel : ObservableObject {
    var activity: ActivityModel
    private var manager: HealthKitManager = HealthKitManager()
    @Published var statusCollection: [StatusModel] = []
    
    static let dateFormatterAxisLabel: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter
    }()
    
    static let dateFormatterValue: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM"
        return formatter
    }()
    
    init(activity: ActivityModel) {
        self.activity = activity
    }
    
    func getChartData() {
        manager.requestHealthInfo(by: activity.id, startDate: Date.oneWeekBefore) { statusCollection in
                DispatchQueue.main.async {
                    self.statusCollection = statusCollection
                }
        }
    }
}
