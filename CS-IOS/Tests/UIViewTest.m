//
//  Created by Rene Dohan on 5/9/12.
//

@import CS_IOS;
@import Quick;
@import Nimble;
@import XCTest;

#import "UIViewTest.h"

@implementation UIViewTest

- (void)testPosition {
    var container = [UIView withSize:200 :200];
    var subview = [container add:[UIView withRect:50 :50 :100 :100]];

    XCTAssertEqual(subview.left, 50);
    XCTAssertEqual(subview.right, 150);
    XCTAssertEqual(subview.fromRight, 50);
    XCTAssertEqual(subview.leftFromRight, 150);
    XCTAssertEqual(subview.top, 50);
    XCTAssertEqual(subview.bottom, 150);
    XCTAssertEqual(subview.fromBottom, 50);
    XCTAssertEqual(subview.topFromBottom, 150);

    subview.fromRight = 25;
    XCTAssertEqual(subview.fromRight, 25);

    subview.fromBottom = 25;
    XCTAssertEqual(subview.fromBottom, 25);
}

- (void)testWidthFromRight {
    var container = [UIView withSize:200 :200];
    var subview = [container add:[UIView withRect:50 :50 :100 :100]];

    XCTAssertEqual(subview.left, 50);
    XCTAssertEqual(subview.right, 150);
    XCTAssertEqual(subview.fromRight, 50);
    XCTAssertEqual(subview.width, 100);

    [subview widthFromRight:50];
    XCTAssertEqual(subview.left, 100);
    XCTAssertEqual(subview.right, 150);
    XCTAssertEqual(subview.fromRight, 50);
    XCTAssertEqual(subview.width, 50);
}

- (void)testMatch {
    val container = [UIView withSize:200 :200];
    val subview = [container add:[UIView withRect:50 :50 :100 :100]];

    XCTAssertEqual(subview.left, 50);
    XCTAssertEqual(subview.fromRight, 50);
    XCTAssertEqual(subview.top, 50);
    XCTAssertEqual(subview.fromBottom, 50);

    subview.matchParentWidth;

    XCTAssertEqual(subview.left, 0);
    XCTAssertEqual(subview.fromRight, 0);
    XCTAssertEqual(subview.top, 50);
    XCTAssertEqual(subview.fromBottom, 50);

    subview.matchParentHeight;

    XCTAssertEqual(subview.left, 0);
    XCTAssertEqual(subview.fromRight, 0);
    XCTAssertEqual(subview.top, 0);
    XCTAssertEqual(subview.fromBottom, 0);

    [subview matchParentWidthWithMargin:50];

    XCTAssertEqual(subview.left, 50);
    XCTAssertEqual(subview.fromRight, 50);
    XCTAssertEqual(subview.top, 0);
    XCTAssertEqual(subview.fromBottom, 0);

    [subview matchParentHeightWithMargin:50];

    XCTAssertEqual(subview.left, 50);
    XCTAssertEqual(subview.fromRight, 50);
    XCTAssertEqual(subview.top, 50);
    XCTAssertEqual(subview.fromBottom, 50);
}

@end
