//
//  Sequence-Sorting.swift
//  
//
//  Created by Tami Black on 1/30/21.
//

import Foundation

extension Sequence {
    
    /// Sorts by by any kind of Value, as long as a comparator function is also provided
    /// - Parameters:
    ///   - keyPath: Elmenent's property KeyPath to sort by
    ///   - areInIncreasingOrder: The compartor function function used for sorting the given Elements
    /// - Throws: areInIncreasingOrder can throw if an exception occurs
    /// - Returns: Sorted Array of Type Element, sorted by given comparator function
    public func sorted<Value>(by keyPath: KeyPath<Element, Value>, using areInIncreasingOrder: (Value, Value) throws -> Bool) rethrows -> [Element] {
        try self.sorted {
            try areInIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath])
        }
    }
    
    /// Sorts by Values conforming to Comparable
    /// - Parameter keyPath: The Elmenent's property KeyPath to sort by
    /// - Returns: Sorted Array of Type Element
    public func sorted<Value: Comparable>(by keyPath: KeyPath<Element, Value>) -> [Element] {
        self.sorted (by: keyPath, using: <)
    }
}
