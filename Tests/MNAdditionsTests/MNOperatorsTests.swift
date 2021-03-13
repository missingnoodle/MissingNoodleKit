//
//  MNOperatorsTests.swift
//  
//
//  Created by Tami Black on 2/7/21.
//

import XCTest
@testable import MNAdditions

final class MNOperatorsTests: XCTestCase {
    // MARK: - Test Custom Initializers
    func testSpaceshipOperatorResultIsLessThan() {
        let left = 2
        let right = 6
        let result = left <=> right
        XCTAssertTrue(result == .orderedAscending, "Since left value is less than right value, the spaceship operator should return -1.")
    }

    func testSpaceshipOperatorResultIsEqualTo() {
        let left = 6
        let right = 6
        let result = left <=> right
        XCTAssertTrue(result == .orderedSame, "Since the left and right values are the same,the spaceship operator should return 0.")
    }

    func testSpaceshipOperatorResultIsGreaterThan() {
        let left = 10.0
        let right = 6.0
        let result = left <=> right
        XCTAssertTrue(result == .orderedDescending, "Since left value is greater than right value, the spaceship operator should return 1.")
    }

    static var allTests = [
        ("testSpaceshipOperatorResultIsLessThan", testSpaceshipOperatorResultIsLessThan),
        ("testSpaceshipOperatorResultIsEqualTo", testSpaceshipOperatorResultIsEqualTo),
        ("testSpaceshipOperatorResultIsGreaterThan", testSpaceshipOperatorResultIsGreaterThan),
    ]
}
