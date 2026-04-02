import XCTest

final class TableOfContentsTests: XCTestCase {
    func testMath() {
        XCTAssertEqual(23, 23)
    }

    func testRead() {
        XCTAssertEqual("text", "text")
    }

    func testAsyncChange() {
        let expectation = expectation(description: "time changed")
        var time = "passing"

        DispatchQueue.main.async {
            time = "done"
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
        XCTAssertEqual("done", time)
    }
}
