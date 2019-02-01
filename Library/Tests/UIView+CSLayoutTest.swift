//  Created by Rene Dohan on 5/9/12.

import Nimble
import Quick
import XCTest
import Renetik

class UIViewTestSwift: XCTestCase {
    func testheightFromBottom() {
        let content = UIView.withSize(200, 200)
        let subview = content.add(UIView.withRect(50, 50, 100, 100))
        XCTAssertEqual(subview.left, 50)
        XCTAssertEqual(subview.right, 150)
        XCTAssertEqual(subview.fromRight, 50)
        XCTAssertEqual(subview.top, 50)
        XCTAssertEqual(subview.bottom, 150)
        XCTAssertEqual(subview.fromBottom, 50)
        XCTAssertEqual(subview.width, 100)
        XCTAssertEqual(subview.height, 100)

        subview.heightFixedBottom(30)

        XCTAssertEqual(subview.left, 50)
        XCTAssertEqual(subview.right, 150)
        XCTAssertEqual(subview.fromRight, 50)
        XCTAssertEqual(subview.top, 120)
        XCTAssertEqual(subview.bottom, 150)
        XCTAssertEqual(subview.fromBottom, 50)
        XCTAssertEqual(subview.width, 100)
        XCTAssertEqual(subview.height, 30)
    }

    func testFromRightToWidth() {
        let content = UIView.withSize(200, 200)
        let subview = content.add(UIView.withRect(50, 50, 100, 100))
        XCTAssertEqual(subview.left, 50)
        XCTAssertEqual(subview.right, 150)
        XCTAssertEqual(subview.fromRight, 50)
        XCTAssertEqual(subview.width, 100)

        subview.fromRight(toWidth: 30)

        XCTAssertEqual(subview.left, 50)
        XCTAssertEqual(subview.right, 170)
        XCTAssertEqual(subview.fromRight, 30)
        XCTAssertEqual(subview.width, 120)
    }

    func testMatchParentWidthWithMargin() {
        let content = UIView.withSize(200, 200)
        let subview = content.add(UILabel.withRect(50, 50, 100, 100))
        XCTAssertEqual(subview.left, 50)
        XCTAssertEqual(subview.right, 150)
        XCTAssertEqual(subview.fromRight, 50)
        XCTAssertEqual(subview.width, 100)

        subview.matchParentWidth(withMargin: 30)

        XCTAssertEqual(subview.left, 30)
        XCTAssertEqual(subview.fromRight, 30)
        XCTAssertEqual(subview.width, 140)

        content.width(400)
        XCTAssertEqual(subview.left, 30)
        XCTAssertEqual(subview.fromRight, 30)
        XCTAssertEqual(subview.width, 340)
    }

    func testMatchParentWidthWithMargin2() {
        let content = UIView.withSize(200, 200)
        let subview = content.add(UILabel.construct()).top(50).height(100).matchParentWidth(withMargin: 30)
        XCTAssertEqual(subview.left, 30)
        XCTAssertEqual(subview.right, 170)
        XCTAssertEqual(subview.fromRight, 30)
        XCTAssertEqual(subview.width, 140)

        content.width(400, height: 400)
        XCTAssertEqual(subview.left, 30)
        XCTAssertEqual(subview.top, 50)
        XCTAssertEqual(subview.fromRight, 30)
        XCTAssertEqual(subview.width, 340)
    }

    func testUILabelSizeFitString() {
        let content = UIView.withSize(200, 200)
        let label = UILabel.construct()
        content.add(label).top(50).height(100).matchParentWidth(withMargin: 30)
        XCTAssertEqual(label.left, 30)
        XCTAssertEqual(label.right, 170)
        XCTAssertEqual(label.fromRight, 30)
        XCTAssertEqual(label.width, 140)
        XCTAssertEqual(label.height, 100)

        label.sizeFit("12345")
        XCTAssertEqual(label.left, 30)
        XCTAssertEqual(label.right, 78.5)
        XCTAssertEqual(label.fromRight, 121.5)
        XCTAssertEqual(label.width, 48.5)
        XCTAssertEqual(label.height, 20.5)
    }
	
	func testUILabelSizeHeightToLines() {
		let content = UIView.withSize(200, 200)
		let label = UILabel.construct()
		content.add(label).top(50).height(100).matchParentWidth(withMargin: 30)
		XCTAssertEqual(label.left, 30)
		XCTAssertEqual(label.right, 170)
		XCTAssertEqual(label.fromRight, 30)
		XCTAssertEqual(label.width, 140)
		XCTAssertEqual(label.height, 100)
		
		label.sizeHeight(toLines: 2)
		XCTAssertEqual(label.left, 30)
		XCTAssertEqual(label.right, 170)
		XCTAssertEqual(label.fromRight, 30)
		XCTAssertEqual(label.width, 140)
		XCTAssertEqual(label.height, 41)
	}
	
}
