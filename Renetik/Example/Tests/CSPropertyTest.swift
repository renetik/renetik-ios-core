//
// Created by Rene Dohan on 2019-01-20.
// Copyright (c) 2019 Renetik Software. All rights reserved.
//

import Renetik
import XCTest

final class CSPropertyTest: XCTestCase {
    func testOnChange() {
        var changeCount = 0
        let value = property("initial") { _ in changeCount += 1 }
        value.value = "second"
        value.value = "third"
        XCTAssertEqual(2, changeCount)
        XCTAssertEqual("third", value.value)
    }

    func testOnApplyAndFire() {
        var changeCount = 0
        let value = property("initial") { _ in changeCount += 1 }.fire()
        value.value = "second"
        value.value = "third"
        XCTAssertEqual(3, changeCount)
        XCTAssertEqual("third", value.value)
    }

    func testNullable() {
        var changeCount = 0
        let value: CSProperty<Int?> = property { (_: Int?) in changeCount += 1 }
        value.value = 0
        value.value = value.value! + 2
        value.value = value.value! + 3
        XCTAssertEqual(5, value.value!)
        XCTAssertEqual(3, changeCount)
    }

    func testEquals() {
        var changeCount = 0
        let value = property("") { _ in changeCount += 1 }
        value.value = "second"
        value.value = "second"
        XCTAssertEqual(1, changeCount)
        XCTAssertEqual("second", value.value)
    }

    func testEventCancel() {
        var changeCount = 0
        let value = property(0)
        value.onChange { registration, changedValue in
            changeCount += changedValue
            if changeCount > 2 { registration.cancel() }
        }
        value.value = 1
        value.value = 2
        value.value = 3
        XCTAssertEqual(3, changeCount)
    }

    func testPropertyPause() {
        var changeCount = 0
        let value = property(0)
        value.onChange { _ in changeCount += 1 }
        value.paused {
            $0.value = 1
            $0.value = 2
            XCTAssertEqual(0, changeCount)
            XCTAssertEqual(2, $0.value)
        }
        XCTAssertEqual(1, changeCount)
        XCTAssertEqual(2, value.value)
    }

    func testPropertyResumeWithoutFire() {
        var changeCount = 0
        let value = property(0)
        value.onChange { _ in changeCount += 1 }
        value.pause()
        value.value = 2
        value.resume(fireChange: false)
        XCTAssertEqual(0, changeCount)
        XCTAssertEqual(2, value.value)
    }

    func testValueWithoutFireNeedsManualFire() {
        var changeCount = 0
        let value = property(0)
        value.onChange { _ in changeCount += 1 }
        value.value(1, fire: false)
        XCTAssertEqual(0, changeCount)
        XCTAssertEqual(1, value.value)
        value.fireChange()
        XCTAssertEqual(1, changeCount)
    }
}
