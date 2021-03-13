//
//  NSRegularExpression+Additions.swift
//  
//
//  Created by Tami Black on 2/28/21.
//

import Foundation

// MARK: - Initializers
public extension NSRegularExpression {
    /// Takes a `StaticString` and returns a non-optional `NSRegularExpression`.  It will fail if the given `StaticString` cannot be initialized as an `NSRegularExpression`.
    /// - Parameter pattern: The `StaticString` (e.g. "^/[A-Z]/") needed to create a non-optional to an `NSRegularExpression`.
    convenience init(_ pattern: StaticString) {
        do {
            try self.init(pattern: "\(pattern)")
        } catch {
            preconditionFailure("Illegal regex: \(pattern).")
        }
    }
}
