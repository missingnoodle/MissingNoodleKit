//
//  Int-Additions.swift
//  
//
//  Created by Tami Black on 2/28/21.
//

import Foundation

// MARK: - Initializers
extension Int {
    /// Takes a `StaticString` and returns a non-optional `Int`.  It will fail if the given `StaticString` cannot be initialized as an `Int`.
    /// - Parameter intString: The `StaticString` (e.g. "1234") to create a non-optional to an `Int`.
    init(_ intString: StaticString) {
        if let intValue = Int("\(intString)") {
            self = intValue
        } else {
            fatalError("Illegal Int: \(intString)")
        }
    }
}

