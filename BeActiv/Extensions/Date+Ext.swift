//
//  Date+Ext.swift
//  BeActive
//
//  Created by Maryam Kaveh on 7/19/1402 AP.
//

import Foundation

extension Date {
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
    
    static var oneWeekBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -6, to: Date()) ?? Date()
//        var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
//        components.day = components.day! - 7
//        guard let oneWeekAgo = Calendar.current.date(from: components) else { return Date() }
//        return oneWeekAgo
    }
    
    static func firstDayOfWeek() -> Date {
        let calendar = Calendar(identifier: .iso8601)
        return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())) ?? Date()
    }
}
