//
//  AddSizeToHtmlImageTagsTest.swift
//  Renetik_Tests
//
//  Created by Rene Dohan on 2/19/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest

final class AddSizeToHtmlImageTagsTest: XCTestCase {
    func testAddSizeToHtmlImageTagOneEmptyTag() {
        let html = "word <img word /> word"
        let result = html.addSizeToHtmlImageTags(200)
        XCTAssertTrue(result.contains("<img word  width='200' height='100' />"))
        XCTAssertEqual(1, result.components(separatedBy: "width='200' height='100'").count - 1)
    }

    func testAddSizeToHtmlImageTagTwooEmptyTags() {
        let html = "word <img word /> word <img word /> word"
        let result = html.addSizeToHtmlImageTags(200)
        XCTAssertEqual(2, result.components(separatedBy: "width='200' height='100'").count - 1)
    }

    func testAddSizeToHtmlImageTagTwooFullTags() {
        let html = "word <img word width='200' height='200'  word /> word <img word width=\"200.0\" height=\"200.0\"  word /> word"
        XCTAssertEqual(html.addSizeToHtmlImageTags(200), html)
    }

    func testAddSizeToHtmlImageOutOfBoundsCrash() {
        let html = "Ahoj v\\u0161ichni,<br \\/>\\r\\nCht\\u011bl jsdm nastartovat motorku a nechce chytit. Jiskru to hazi, ale motor neto\\u010d\\u00ed. Baterka by m\\u011bla b\\u00fdt pln\\u011b nabita, ale m\\u016f\\u017eu z\\u00edtra jesze zkusit jinou. Na f\\u00f3rech jsem \\u010detl hodn\\u011b, ale nevyzn\\u00e1m se v tom moc, tak\\u017ee nev\\u00edm, jestli ode\\u0161el start\\u00e9r, nebo co zkusit a tak. Budu r\\u00e1d za ka\\u017edou radu, p\\u0159ikl\\u00e1d\\u00e1m video zvuku, kter\\u00fd to d\\u011bl\\u00e1 p\\u0159i snaze nastartovat. <br \\/>\\r\\n<br \\/>\\r\\nDekuji za rady, <br \\/>\\r\\n<br \\/>\\r\\n<a href='https:\\/\\/www.youtube.com\\/watch?v=yADL2mGOcMg'><img src='https:\\/\\/i.ytimg.com\\/vi\\/yADL2mGOcMg\\/hqdefault.jpg'\\/><br\\/>Spustit<\\/a> "
        let result = html.addSizeToHtmlImageTags(200)
        XCTAssertTrue(result.contains("width='200' height='100'"))
    }
}
