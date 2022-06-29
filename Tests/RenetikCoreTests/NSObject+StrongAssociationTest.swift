import XCTest
@testable import RenetikCore

fileprivate class TestObject {
    var testString = "initial"
}
fileprivate extension XCTestCase {
    var variable: TestObject { associated("testVariable") { TestObject() } }
    var weakVariable: TestObject? {
        get { weakAssociated("weakVariable") }
        set { weakAssociate("weakVariable", newValue) }
    }
}
final class NSObjectAssociationTest: XCTestCase {
    func testAssociatedXCTestCaseStrongVariableInExtension() throws {
        XCTAssertEqual("initial", variable.testString)
        variable.testString = "newString"
        XCTAssertEqual("newString", variable.testString)
    }
    fileprivate var testObject: TestObject? = TestObject()
    func testAssociatedXCTestCaseWeakVariableInExtension() throws {
        XCTAssertNil(weakVariable)
        weakVariable = testObject
        XCTAssertEqual("initial", weakVariable!.testString)
        testObject!.testString = "newString"
        XCTAssertEqual("newString", weakVariable!.testString)
        testObject = nil
        XCTAssertNil(weakVariable)
    }
}
