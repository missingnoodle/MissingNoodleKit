//
//  Comparable-Additions.swift
//  
//
//  Created by Tami Black on 2/28/21.
//

import Foundation

// MARK: - Infix Operator
// Expects operands on both sides of the operator
infix operator <=>

// MARK: - Function
/// The spaceship comparison operator
/// - Parameters:
///   - lhs: The  left hand side` Comparable` value to compare against
///   - rhs: The  right hand side `Comparable` value to compare against
/// - Returns: if lhs < rhs returns -l, if lhs > rhs returns 1, otherwise returns 0
public func <=><T: Comparable>(lhs: T, rhs: T) -> ComparisonResult {
    if lhs < rhs { return .orderedAscending }
    if lhs > rhs { return .orderedDescending }
    return .orderedSame
}

// MARK: - Functions
public extension Comparable {
    /// Forces the returned `Comparable` value to fall within the range of the given `low` and given `high` values.
    /// - Parameters:
    ///   - low: The minimal value of the range to clamp. E.g. If `self` is `5` and `low` is  `10`; `5` is returned
    ///   - high: The maximum value of the range to clamp,  E.g. If `self` is `25` and `high` is  `20`;  `20` is returned
    /// - Returns: self (the `Comparable` value) if it falls within the range of the `low...high Comparable` values, or  the `low` or `high` value
    func clamp(low: Self, high: Self) -> Self {
        if self < low {
            return low
        } else if self > high {
            return high
        } else {
            return self
        }
    }
}
