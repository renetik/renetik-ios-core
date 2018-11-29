//  Created by Rene Dohan on 5/9/12.

import Quick
import Nimble
import XCTest
import Renetik

class UIViewTestSwift: XCTestCase {
    
    func testFromRightToWidth() {
        let content = UIView.withSize(200, 200)
        let subview = content.add(UIView.withRect(50, 50, 100, 100))
        XCTAssertEqual(subview.left(), 50)
        XCTAssertEqual(subview.right(), 150)
        XCTAssertEqual(subview.fromRight(), 50)
        XCTAssertEqual(subview.width(), 100)
        
        subview.fromRight(toWidth:30)
        
        XCTAssertEqual(subview.left(), 50)
        XCTAssertEqual(subview.right(), 170)
        XCTAssertEqual(subview.fromRight(), 30)
        XCTAssertEqual(subview.width(), 120)
    }
    
    func testMatchParentWidthWithMargin() {
        let content = UIView.withSize(200, 200)
        let subview = content.add(UILabel.withRect(50, 50, 100, 100))
        XCTAssertEqual(subview.left(), 50)
        XCTAssertEqual(subview.right(), 150)
        XCTAssertEqual(subview.fromRight(), 50)
        XCTAssertEqual(subview.width(), 100)
        
        subview.matchParentWidth(withMargin: 30)
        
        XCTAssertEqual(subview.left(), 30)
        XCTAssertEqual(subview.fromRight(), 30)
        XCTAssertEqual(subview.width(), 140)
        
        content.width(400)
        XCTAssertEqual(subview.left(), 30)
        XCTAssertEqual(subview.fromRight(), 30)
        XCTAssertEqual(subview.width(), 340)
    }
    
    func testMatchParentWidthWithMargin2() {
        let content = UIView.withSize(200, 200)
        let subview = content.add(UILabel.construct()).top(50).height(100).matchParentWidth(withMargin: 30)
        XCTAssertEqual(subview.left(), 30)
        XCTAssertEqual(subview.right(), 170)
        XCTAssertEqual(subview.fromRight(), 30)
        XCTAssertEqual(subview.width(), 140)
        
        content.width(400, height: 400)
        XCTAssertEqual(subview.left(), 30)
        XCTAssertEqual(subview.top(), 50)
        XCTAssertEqual(subview.fromRight(), 30)
        XCTAssertEqual(subview.width(), 340)
    }
}
