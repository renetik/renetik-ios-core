//  Created by Rene Dohan on 5/9/12.

import Nimble
import Quick
import Renetik
import XCTest

class UIViewTestSwift: XCTestCase {
    func testPosition() {
        let container = UIView.withSize(200, 200)
        let subview = container.add(view: UIView.withRect(50, 50, 100, 100))

        XCTAssertEqual(subview.left, 50)
        XCTAssertEqual(subview.right, 150)
        XCTAssertEqual(subview.fromRight, 50)
        XCTAssertEqual(subview.leftFromRight, 150)
        XCTAssertEqual(subview.top, 50)
        XCTAssertEqual(subview.bottom, 150)
        XCTAssertEqual(subview.fromBottom, 50)
        XCTAssertEqual(subview.topFromBottom, 150)

        subview.fromRight(25)
        XCTAssertEqual(subview.fromRight, 25)

        subview.fromBottom(25)
        XCTAssertEqual(subview.fromBottom, 25)
    }

    func testWidthFromRight() {
        let container = UIView.withSize(200, 200)
        let subview = container.add(UIView.withRect(50, 50, 100, 100))

        XCTAssertEqual(subview.left, 50)
        XCTAssertEqual(subview.right, 150)
        XCTAssertEqual(subview.fromRight, 50)
        XCTAssertEqual(subview.width, 100)

        subview.widthFixedRight(50)
        XCTAssertEqual(subview.left, 100)
        XCTAssertEqual(subview.right, 150)
        XCTAssertEqual(subview.fromRight, 50)
        XCTAssertEqual(subview.width, 50)
    }

    func testMatch() {
        let container = UIView.withSize(200, 200)
        let subview = container.add(UIView.withRect(50, 50, 100, 100))

        XCTAssertEqual(subview.left, 50)
        XCTAssertEqual(subview.fromRight, 50)
        XCTAssertEqual(subview.top, 50)
        XCTAssertEqual(subview.fromBottom, 50)

        subview.matchParentWidth()

        XCTAssertEqual(subview.left, 0)
        XCTAssertEqual(subview.fromRight, 0)
        XCTAssertEqual(subview.top, 50)
        XCTAssertEqual(subview.fromBottom, 50)

        subview.matchParentHeight()

        XCTAssertEqual(subview.left, 0)
        XCTAssertEqual(subview.fromRight, 0)
        XCTAssertEqual(subview.top, 0)
        XCTAssertEqual(subview.fromBottom, 0)

        subview.matchParentWidth(withMargin: 50)

        XCTAssertEqual(subview.left, 50)
        XCTAssertEqual(subview.fromRight, 50)
        XCTAssertEqual(subview.top, 0)
        XCTAssertEqual(subview.fromBottom, 0)

        subview.matchParentHeight(withMargin: 50)

        XCTAssertEqual(subview.left, 50)
        XCTAssertEqual(subview.fromRight, 50)
        XCTAssertEqual(subview.top, 50)
        XCTAssertEqual(subview.fromBottom, 50)
    }

    func testMatchParentWithMargin() {
        let content = UIView.withSize(200, 200)
		let subview = content.add(view: UILabel.construct())
			.top(50).height(100).matchParentWidth(withMargin: 30)
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

    func testHeightFromBottom() {
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
        XCTAssertTrue(label.left > 29)
        XCTAssertTrue(label.right > 78)
        XCTAssertTrue(label.fromRight > 121)
        XCTAssertTrue(label.width > 48)
        XCTAssertTrue(label.height > 20)
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
        XCTAssertTrue(label.height > 40)
    }
}
