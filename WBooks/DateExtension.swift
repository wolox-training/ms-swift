//
//  DateExtension.swift
//  WBooks
//
//  Created by Matías David Schwalb on 04/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation

public extension Date {
    static func getCurrentDateYYYY_MM_DD() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    static func addDaysToCurrentDateYYYY_MM_DD(daysToAdd: Int) -> String {
        let today = Date()
        let futureDay = Calendar.current.date(byAdding: .day, value: daysToAdd, to: today)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: futureDay)
    }
}
