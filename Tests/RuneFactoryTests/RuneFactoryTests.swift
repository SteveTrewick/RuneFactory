import XCTest
@testable import RuneFactory

final class RuneFactoryTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(RuneFactory().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
