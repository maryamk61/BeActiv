//
//  StatusModel.swift
//  BeActiv
//
//  Created by Maryam Kaveh on 7/26/1402 AP.
//

import Foundation
import HealthKit

struct StatusModel: Identifiable {
    var id: String
    var date: Date
    var value: HKQuantity?
    
    static var mockStatus: StatusModel {
        StatusModel(id: "stepCount", date: Date())
    }
}
