//
// Created by Rene Dohan on 2019-01-20.
// Copyright (c) 2019 Renetik Software. All rights reserved.
//

import Nimble
import Quick
import XCTest
import RenetikCore

class TestClass: NSObject {
    var testString = ""

    init(_ testString: String) {
        self.testString = testString
    }
}

class CSLangTest: XCTestCase {
    let nonOptionalString: String = "initial"
    let optionalStringWithValue: String? = "initial"
    let optionalStringWithNil: String? = nil

    let nonOptionalTestClass: TestClass = TestClass("initial")
    let optionalTestClassWithValue: TestClass? = TestClass("initial")
    let optionalTestClassWithNil: TestClass? = nil

    func testIsNil() {
        XCTAssertFalse(nonOptionalString.isNil)
        XCTAssertFalse(optionalStringWithValue.isNil)
        XCTAssertTrue(optionalStringWithNil.isNil)
    }

    func testNotNil() {
        XCTAssertTrue(nonOptionalString.notNil)
        XCTAssertTrue(optionalStringWithValue.notNil)
        XCTAssertFalse(optionalStringWithNil.notNil)
    }

    func testAsString() {
        XCTAssertEqual("initial", nonOptionalString.asString)
        XCTAssertEqual("initial", optionalStringWithValue.asString)
        XCTAssertEqual("", optionalStringWithNil.asString)
    }

    func testAlso() {
        XCTAssertEqual("initial", nonOptionalTestClass.testString)
        XCTAssertEqual("other", nonOptionalTestClass.also { $0.testString = "other" }.testString)

        XCTAssertEqual("initial", optionalTestClassWithValue?.testString)
        XCTAssertEqual("other", optionalTestClassWithValue?.also { $0.testString = "other" }.testString)

        XCTAssertNil(optionalTestClassWithNil?.testString)
        XCTAssertNil(optionalTestClassWithNil?.also { $0.testString = "other" }.testString)
    }

    func testThen() {
        XCTAssertEqual("initial", nonOptionalTestClass.testString)
        nonOptionalTestClass.then { $0.testString = "other" }
        XCTAssertEqual("other", nonOptionalTestClass.testString)

        XCTAssertEqual("initial", optionalTestClassWithValue?.testString)
        optionalTestClassWithValue?.then { $0.testString = "other" }
        XCTAssertEqual("other", optionalTestClassWithValue?.testString)

        XCTAssertNil(optionalTestClassWithNil?.testString)
        optionalTestClassWithNil?.then { $0.testString = "other" }
        XCTAssertNil(optionalTestClassWithNil?.testString)
    }

    func testRet() {
        XCTAssertEqual("initial", nonOptionalTestClass.testString)
        XCTAssertEqual("returned", nonOptionalTestClass.ret {
            $0.testString = "other"
            return "returned"
        })
        XCTAssertEqual("other", nonOptionalTestClass.testString)

        XCTAssertEqual("initial", optionalTestClassWithValue?.testString)
        XCTAssertEqual("returned", optionalTestClassWithValue?.ret {
            $0.testString = "other"
            return "returned"
        })
        XCTAssertEqual("other", optionalTestClassWithValue?.testString)

        XCTAssertNil(optionalTestClassWithNil?.testString)
        XCTAssertNil(optionalTestClassWithNil?.ret {
            $0.testString = "other"
            return "returned"
        })
        XCTAssertNil(optionalTestClassWithNil?.testString)
    }

    func testCast() {
        let array: NSMutableArray? = NSMutableArray()
        array?.add("test string 1")
        array?.add("test string 2")
        let stringArray: [String] = array as! [String]
        XCTAssertEqual("test string 2", stringArray[1])
    }
}
