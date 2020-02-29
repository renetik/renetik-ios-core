//
//  UILabel+CSExtension.swift
//  Renetik
//
//  Created by Rene Dohan on 3/6/19.
//

import UIKit
import RenetikObjc

public extension UILabel {

    override func construct() -> Self {
        super.construct()
        lineBreakMode = .byTruncatingTail
        return self
    }

    var fontSize: CGFloat {
        get {
            font.pointSize
        }
        set(size) {
            font = font.withSize(size)
        }
    }

    @discardableResult
    func fontSize(_ size: CGFloat) -> Self { invoke { fontSize = size } }

    var fontStyle: UIFont.TextStyle {
        get {
            font.fontDescriptor.object(forKey: .textStyle) as! UIFont.TextStyle
        }
        set(style) {
            font = UIFont.preferredFont(forTextStyle: style)
        }
    }

    @discardableResult
    func fontStyle(_ style: UIFont.TextStyle) -> Self { invoke { fontStyle = style } }

    @discardableResult
    func font(_ font: UIFont) -> Self { invoke { self.font = font } }

    @discardableResult
    func textColor(_ textColor: UIColor) -> Self { invoke { self.textColor = textColor } }

    @discardableResult
    public func withBoldFont(if condition: Bool = true) -> Self {
        invoke { font = condition ? font.bold() : font.normal() }
    }

    @discardableResult
    func text(_ string: String) -> Self { invoke { text = string } }

    @discardableResult
    func textAlign(_ alignment: NSTextAlignment) -> Self { invoke { textAlignment = alignment } }

    @discardableResult
    func lineBreak(_ mode: NSLineBreakMode) -> Self { invoke { lineBreakMode = mode } }

    @discardableResult
    func hideIfEmpty() -> Self { invoke { self.visible = text?.trim.isSet == true } }

    @discardableResult
    override func heightToFit() -> Self {
        numberOfLines = 0
        super.heightToFit()
        return self
    }

    @discardableResult
    func resizeToFit(_ value: String) -> Self {
        numberOfLines = 0
        let current = text
        return text(value).resizeToFit().text(current ?? "")
    }

    @discardableResult
    func heightToFit(_ value: String) -> Self {
        numberOfLines = 0
        let current = text
        text = value
        height = calculateHeightToFitWidth()
        text = current
        return self
    }

    @discardableResult
    func heightToFit(lines numberOfLines: Int) -> Self {
        let currentText = text
        self.text = "cjksjkljaskljfklsaj fjas klfjaslk jfklaj fklaj fkljs aklfj klasj" +
                " fljsahflasljh sdiaf uiau fiahfiohe iof aeuhfkuaedfiuaehfueahkufheuafuaehfoiuyeaoif " +
                "aeil fklaehjlfhaekjfhgkaegfjgeauklfeakuhfkluaehkfheaklufhkljaehfk hleauk " +
                "fhlkuaehfjkaekfgeakfgkalehfkjahekjlfhkjelhqfkheukfglkgfalkjgfkagefjklgaekfgeajk" +
                " fljsahflasljh sdiaf uiau fiahfiohe iof aeuhfkuaedfiuaehfueahkufheuafuaehfoiuyeaoif " +
                "aeil fklaehjlfhaekjfhgkaegfjgeauklfeakuhfkluaehkfheaklufhkljaehfk hleauk " +
                "fhlkuaehfjkaekfgeakfgkalehfkjahekjlfhkjelhqfkheukfglkgfalkjgfkagefjklgaekfgeajk" +
                " fljsahflasljh sdiaf uiau fiahfiohe iof aeuhfkuaedfiuaehfueahkufheuafuaehfoiuyeaoif " +
                "aeil fklaehjlfhaekjfhgkaegfjgeauklfeakuhfkluaehkfheaklufhkljaehfk hleauk " +
                "fhlkuaehfjkaekfgeakfgkalehfkjahekjlfhkjelhqfkheukfglkgfalkjgfkagefjklgaekfgeajk" +
                " fljsahflasljh sdiaf uiau fiahfiohe iof aeuhfkuaedfiuaehfueahkufheuafuaehfoiuyeaoif " +
                "aeil fklaehjlfhaekjfhgkaegfjgeauklfeakuhfkluaehkfheaklufhkljaehfk hleauk " +
                "fhlkuaehfjkaekfgeakfgkalehfkjahekjlfhkjelhqfkheukfglkgfalkjgfkagefjklgaekfgeajk"
        self.numberOfLines = numberOfLines
        super.heightToFit()
        text = currentText
        return self
    }

    @discardableResult
    func html(_ text: String) -> Self {
        let htmlStyleFormat = "<style>body{font-family: '%@'; font-size:%fpx;}</style>"
        if let data = (text + String(format: htmlStyleFormat, font.fontName, font.pointSize)).data(using: .unicode) {
            attributedText = try? NSAttributedString(data: data, options: [
                .documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8
            ], documentAttributes: nil)
        }
        return self
    }

}
