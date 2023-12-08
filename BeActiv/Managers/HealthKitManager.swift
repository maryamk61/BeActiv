//
//  HealthKitManager.swift
//  BeActiv
//
//  Created by Maryam Kaveh on 7/23/1402 AP.
//

import Foundation
import HealthKit

final class HealthKitManager {
    let store: HKHealthStore?
    var statusCollection: [StatusModel] = []
    var todayCollection: [ActivityModel?] = []
    var allStatusCollections: [String: [StatusModel]] = [:]

    let allTypes = Set([
        HKObjectType.quantityType(forIdentifier: .stepCount)!,
        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
        HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!,
        HKObjectType.quantityType(forIdentifier: .appleStandTime)!,
        HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
    ])
    
    init() {
        self.store = HKHealthStore()
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> ()) {
        guard let store else {
            return
        }
        
        store.requestAuthorization(toShare: [], read: allTypes) { success, error in
            if let error {
                #if DEBUG
                print("Error occured while getting permission: \(error)")
                #endif
               return
            }
            completion(success)
        }
    }
    
    func requestHealthInfo(by category: String, startDate: Date, completion: @escaping ([StatusModel])-> ()) {
        
        guard let store , let type = HKObjectType.quantityType(forIdentifier: getTypeByCategory(category: category)) else {
            return
        }
        
        let anchorDate = Date.firstDayOfWeek()
        let dailyComponent = DateComponents(day: 1) // we want data in each day to be fetched
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        let query = HKStatisticsCollectionQuery(quantityType: type, quantitySamplePredicate: predicate, options: .cumulativeSum ,anchorDate: anchorDate , intervalComponents: dailyComponent)
        
        query.initialResultsHandler  = { [weak self] query, collection , error in
            if let error {
                #if DEBUG
                print("Error occured while getting health statistics: \(error)")
                #endif
               return
            }
            self?.statusCollection.removeAll()
            var dateOffset = 0
            collection?.enumerateStatistics(from: Date.oneWeekBefore, to: Date(), with: {[weak self] stats, _ in
                guard let sumQuantity = stats.sumQuantity() else {
                  return
                }
                let status = StatusModel(id:category ,date: Calendar.current.date(byAdding: .day, value: dateOffset, to: Date.oneWeekBefore) ?? Date(), value: sumQuantity)
                dateOffset += 1
                
                self?.statusCollection.append(status)
            })

            completion(self?.statusCollection ?? [])
        }
        store.execute(query)
    }
    
    func requestHealthInfoAsync(by category: String, startDate: Date) async -> [StatusModel] {
        return await withCheckedContinuation({ continuation in
            requestHealthInfo(by: category, startDate: startDate) { stats in
                continuation.resume(returning: stats)
            }
        })
    }
    
    func requestAllHealthInfo(startDate: Date) async -> [String: [StatusModel]] {
        async let stepsArrayResult = requestHealthInfoAsync(by: "stepCount", startDate: startDate)
        async let energyArrayResult = requestHealthInfoAsync(by: "activeEnergyBurned", startDate: startDate)
        async let exerciseArrayResult = requestHealthInfoAsync(by: "appleExerciseTime", startDate: startDate)
        async let walkArrayResult = requestHealthInfoAsync(by: "distanceWalkingRunning", startDate: startDate)
        async let standArrayResult = requestHealthInfoAsync(by: "appleStandTime", startDate: startDate)

        let (steps, energy, exercise, walk, stand) = await (stepsArrayResult, energyArrayResult, exerciseArrayResult, walkArrayResult, standArrayResult )
        allStatusCollections["stepCount"] = steps
        allStatusCollections["activeEnergyBurned"] = energy
        allStatusCollections["appleExerciseTime"] = exercise
        allStatusCollections["distanceWalkingRunning"] = walk
        allStatusCollections["appleStandTime"] = stand
        
        return allStatusCollections.filter({!$0.value.isEmpty})
    }
    
    func requestTodayHealthInfoAsync(by category: String) async -> ActivityModel? {
        guard let store , let type = HKObjectType.quantityType(forIdentifier: getTypeByCategory(category: category)) else {
            return nil
        }
        let predicate = HKQuery.predicateForSamples(withStart: Date.startOfDay, end: Date(),options: .strictStartDate)

        // Create the query descriptor.
        let predicate2 = HKSamplePredicate.quantitySample(type: type, predicate:predicate)
        let descriptor = HKStatisticsQueryDescriptor(predicate: predicate2, options: .cumulativeSum)
        // Run query
        let result = try? await descriptor.result(for: store)
        guard let sumQuantity = result?.sumQuantity() else {
          return nil
        }
     
        let activity = ActivityModel(id: category, todayValue: Double(HKQuantityHelper.getValue(from: sumQuantity).value), todayDesc: HKQuantityHelper.getValue(from: sumQuantity).desc, weeklyGoal: UserDefaults.standard.double(forKey: category))
        return activity
    }
    
    func requestTodayAllHealthInfo() async -> [ActivityModel] {
        async let stepsResult = requestTodayHealthInfoAsync(by: "stepCount")
        async let energyResult = requestTodayHealthInfoAsync(by: "activeEnergyBurned")
        async let exerciseResult = requestTodayHealthInfoAsync(by: "appleExerciseTime")
        async let walkResult = requestTodayHealthInfoAsync(by: "distanceWalkingRunning")
        async let standResult = requestTodayHealthInfoAsync(by: "appleStandTime")
        
        let (steps, energy, exercise, walk, stand) = await (stepsResult, energyResult, exerciseResult, walkResult, standResult )
        let collection: [ActivityModel?] = [steps, energy, exercise, walk, stand]
        return collection.compactMap { $0 }
    }
}

extension HealthKitManager {
    private func getTypeByCategory(category :String) ->  HKQuantityTypeIdentifier {
        switch category {
        case "stepCount":
            return .stepCount
        case "activeEnergyBurned":
            return .activeEnergyBurned
        case "appleExerciseTime":
            return .appleExerciseTime
        case "distanceWalkingRunning":
            return .distanceWalkingRunning
        case "appleStandTime":
            return .appleStandTime
        default:
            return .stepCount
        }
    }
}
