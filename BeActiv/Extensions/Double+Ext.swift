//
//  Double+Ext.swift
//  BeActive
//
//  Created by Maryam Kaveh on 7/20/1402 AP.
//

import Foundation

extension Double {
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        
        return numberFormatter
    }
    
    func formattedString() -> String {
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
    
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
