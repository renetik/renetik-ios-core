//
//  UILabel+CSExtension.swift
//  Renetik
//
//  Created by Rene Dohan on 3/6/19.
//

import UIKit
import RenetikObjc

public extension UILabel {

    class func construct(_ text: String) -> Self { construct().text(text) }

    override func construct() -> Self {
        super.construct(); text(lines: 0).text(break: .byTruncatingTail); return self
    }

    @discardableResult
    func text(color: UIColor) -> Self { self.textColor = textColor; return self }

    @discardableResult
    func text(align: NSTextAlignment) -> Self { textAlignment = align; return self }

    @discardableResult
    func text(break mode: NSLineBreakMode) -> Self { lineBreakMode = mode; return self }

    @discardableResult
    func text(lines: Int) -> Self { numberOfLines = lines; return self }

    @discardableResult
    override func heightToFit() -> Self { text(lines: 0); super.heightToFit(); return self }

    @discardableResult
    func resizeToFit(_ value: String) -> Self {
        text(lines: 0); let current = text; return text(value).resizeToFit().text(current ?? "")
    }

    @discardableResult
    func heightToFit(_ value: String) -> Self {
        text(lines: 0)
        let current = text; text = value; height = heightThatFits(); text = current
        return self
    }

    @discardableResult
    func heightToFit(lines numberOfLines: Int) -> Self {
        let currentWidth = width; let currentText = text; var linesText = "line"
        for i in 0..<numberOfLines - 1 { linesText += "\n line" }
        text(linesText).resizeToFit().text(currentText).width(currentWidth)
        return self
    }
}

extension UILabel: CSHasTextProtocol {
    public func text() -> String? { text }

    public func text(_ text: String?) { self.text = text }
}

extension UILabel: CSHasFontProtocol {
    public func font() -> UIFont? { font }

    public func font(_ font: UIFont?) { self.font = font }
}
