//
//  HKQuantityValue.swift
//  BeActiv
//
//  Created by Maryam Kaveh on 8/8/1402 AP.
//

import Foundation
import HealthKit

struct HKQuantityHelper {
    static let measurementFormatter = MeasurementFormatter()

    static func getValue(from activity: HKQuantity?) -> (value: Double, desc: String) {

        guard let activity = activity else {return (0, "")}
        if activity.is(compatibleWith: .kilocalorie()) {
            let value = activity.doubleValue(for: .kilocalorie())
            let unit = Measurement(value: value.round(to: 0), unit: UnitEnergy.kilocalories)
            return ((value.round(to: 0)), unit.description)
        } else if activity.is(compatibleWith: .meter()) {
            let value = activity.doubleValue(for: .mile())
            let unit = Measurement(value: value.round(to: 2), unit: UnitLength.miles)
            return ((value.round(to: 2)) , unit.description)
        } else if activity.is(compatibleWith: .count()) {
            let value = activity.doubleValue(for: .count())
            return ((value.round(to: 1)), activity.description)
        } else if activity.is(compatibleWith: .minute()) {
            let value = activity.doubleValue(for: .minute())
            return ((value.round(to: 1)), activity.description)
        }
        
        return (0, "")
    }
}

