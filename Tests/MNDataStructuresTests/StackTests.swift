import XCTest
@testable import MNDataStructures

final class StackTests: XCTestCase {
    // MARK: - Test Custom Initializers
    func testInitWithIntArray() {
        let array = [1, 2, 3, 4, 5]
        let stack = Stack<Int>(array)
        XCTAssertNotNil(stack, "Initializing a Stack with a passed in array failed.")
    }

    func testInitWithStringArrayLiteral() {
        let stack: Stack = ["first", "two", "three", "four", "last"]
        XCTAssertNotNil(stack, "Initializing a Stack with an array literal in array failed.")
    }

    // MARK: - Helper/Metadata Property Tests
    func testCount() {
        let stack: Stack = [true, false, true, true, false]
        XCTAssert(stack.count == 5, "stack.count should return false")
    }

    func testIsEmpty() {
        let stack: Stack = [UIColor.black, UIColor.white]
        XCTAssertFalse(stack.isEmpty, "\(stack).isEmpty should return false")
    }

    // MARK: - Operation Tests
    func testPush() {
        var stack1 = Stack<Bool>()
        stack1.push(true)
        XCTAssert(stack1.count == 1, "\(stack1).count should return count of 1.")

        var stack2: Stack = ["first", "two", "three"]
        stack2.push("four")
        stack2.push("last")
        XCTAssert(stack2.count == 5, "\(stack2).count should return count of 5.")
    }

    func testPop() {
        var stack1: Stack = [1.0]
        _ = stack1.pop()
        XCTAssertTrue(stack1.isEmpty, "\(stack1) should be empty")

        var stack2: Stack = [1.0, 2.1, 3.2, 4.3, 5.4]
        let poppedElement = stack2.pop()
        XCTAssert(poppedElement == 5.4, "poppedElement:\(poppedElement!) should = 5.4")

        _ = stack2.pop()
        XCTAssert(stack2.count == 3, "\(stack2).count: \(stack2.count) should return count of 3.")
    }

    func testPeek() {
        let stack: Stack = [" ❌", "✅"]
        XCTAssert(stack.peek() == "✅", "stack.peek(): \(stack.peek()!) should return ✅")
    }

    // MARK: - Testing Protocol Conformance
    func testEquatable() {
         let stackA = Stack([1, 2, 3])
         let stackB = Stack([1, 2, 3])
        XCTAssert(stackA == stackB, "\(stackA) and \(stackB) are not equal")

        let stackA1 = Stack([1, 2, 3])
        let stackB1 = Stack([1, 2, 3, 4])
        XCTAssert(stackA1 != stackB1, "\(stackA) and \(stackB) are equal")
    }

    static var allTests = [
        ("testInitWithIntArray", testInitWithIntArray),
        ("testInitWithStringArrayLiteral", testInitWithStringArrayLiteral),
        ("testCount", testCount),
        ("testIsEmpty", testIsEmpty),
        ("testPush", testPush),
        ("testPop", testPop),
        ("testPeek", testPeek),
        ("testEquatable", testEquatable),
    ]
}
