import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(MNDataStructuresTests.allTests),
    ]
}
#endif
