//
//  Date-Additions.swift
//  
//
//  Created by Tami Black on 2/25/21.
//

import Foundation

// MARK: - Properties
public extension Date {
    
    /// Determines wether the given date comes before the current `Date()`
    var isInFuture: Bool {
        self > Date()
    }

    /// Captures wether the given date comes after the current `Date()`
    var isInPast: Bool {
        self < Date()
    }
}

// MARK: - Functions
public extension Date {
    func ISO8601Date() -> String {
        let formatter = ISO8601DateFormatter()
        return formatter.string(from: self)
    }

    /// The number of days between a given `Date` and `now`
    /// - Parameter otherDate: The given `Date` making up the `Date range` 
    /// - Returns: The number of days between `now` and the given `Date` range
    func days(between otherDate: Date) -> Int {
        let calendar = Calendar.current

        let startOfSelf = calendar.startOfDay(for: self)
        let starOfOther = calendar.startOfDay(for: otherDate)
        let components = calendar.dateComponents([.day], from: startOfSelf, to: starOfOther)

        return abs(components.day ?? 0)
    }
}
