//
//  Date+Utils.swift
//  Bankey
//
//  Created by Bryan Yong on 18/09/2022.
//

import Foundation

extension Date {
    static var bankeyDateFormatter : DateFormatter{
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "MDT")
        return formatter
    }

    var monthDayYearString : String {
        let dateFormatter = Date.bankeyDateFormatter
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
    
}
