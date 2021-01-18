import XCTest
@testable import MissingNoodleKit

final class MissingNoodleKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(MissingNoodleKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
