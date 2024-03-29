//
//  Stack.swift
//  MissingNoodlePortfolio
//
//  Created by Tami Black on 1/16/21.
//

import Foundation

public struct Stack<Element> {
    private var stack = [Element]()
    
    // MARK: - Helper/Metadata Properties
    public var count: Int { stack.count }
    public var isEmpty: Bool { stack.isEmpty }

    // MARK: - Required Operations
    public mutating func push(_ element: Element) {
        stack.append(element)
    }

    public mutating func pop() -> Element? {
        stack.popLast()
    }

    // MARK: - Optional Opertions
    public func peek() -> Element? {
        stack.last
    }
}

// MARK: - Initializers
public extension Stack {
    init (_ items: [Element]) {
        self.stack = items
    }
}

extension Stack: ExpressibleByArrayLiteral {
    /// Allows Stacks to be created using the following syntax: `var numbers: Stack = [1, 2, 3, 4, 5]`
    public init(arrayLiteral elements: Element...) {
        self.stack = elements
    }
}

// MARK: - Protocol Conformance:
// MARK: - Equatable & Hashable

/// The empty Equatable Stack extension allows for:
/// `let stackA = Stack([1, 2, 3])`
/// `let stackB = Stack([1, 2, 3])`
/// ` print(stackA == stackB)` , prints true6 kl;pp-[--------[p;nebvfdxxxsssxcxswwsxx-=]
extension Stack: Equatable where Element: Equatable { }
extension Stack: Hashable where Element: Hashable { }

// MARK: - Decodable & Encodable
/// Conforming to both Decodable and Encodable is more flexible than conforming to Codable
extension Stack: Decodable where Element: Decodable { }
extension Stack: Encodable where Element: Encodable { }

// MARK: CustomDebugStringConvertible
extension Stack: CustomDebugStringConvertible {
    /// Prints a stack in the form of : [1, 2, 3, 4, 5]
    public var debugDescription: String {
        var result = "["
        var first = true

        for item in stack {
            if first {
                first = false
            } else {
                result += ", "
            }

            debugPrint(item, terminator: "", to: &result)
        }
        result += "]"
        return result
    }
}
