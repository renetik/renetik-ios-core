//
// Created by Rene Dohan on 1/4/20.
//

import Foundation
import UIKit
import BlocksKit

private let previousTextKey = "UITextField+CSExtension.swift:onTextChange:PreviousText"

public extension UITextField {

    @objc func caretRect(for position: UITextPosition) -> CGRect { CGRect.zero }

    @discardableResult
    func clear() -> Self { invoke { self.text = "" } }

    @discardableResult
    func togglePasswordVisibility() -> Self {
        isSecureTextEntry = !isSecureTextEntry
        let existingText = text
        if isSecureTextEntry {
            deleteBackward()
            text = existingText
        }
        return self
    }

    @discardableResult
    func leftInsetByLeftView(width: CGFloat) -> Self {
        let leftView = UIView.construct(width: width, height: 1)
        leftView.backgroundColor = backgroundColor
        self.leftView = leftView
        leftViewMode = .always
        return self
    }

    @discardableResult
    func onChange(_ function: @escaping (UITextField) -> Void) -> Self {
        bk_addEventHandler({ _ in function(self) }, for: .editingChanged)
        return self
    }


    @discardableResult
    func onTextChange(_ function: @escaping (UITextField) -> Void) -> Self {
        bk_addEventHandler({ [self] _ in
            if text != values[previousTextKey] as? String {
                values[previousTextKey] = text
                function(self)
            }
        }, for: .editingChanged)
        return self
    }

    @discardableResult
    func onClear(_ function: @escaping (UITextField) -> Void) -> Self {
        bk_shouldClearBlock = { _ in
            function(self)
            return true
        }
        return self
    }

    @discardableResult
    func text(html: String) -> Self {
        let htmlStyleFormat = "<style>body{font-family: '%@'; font-size:%fpx;}</style>"
        let html = (text + String(format: htmlStyleFormat, font!.fontName, font!.pointSize))
        let htmlData = html.data(using: .unicode, allowLossyConversion: true)
        htmlData.notNil { data in
            attributedText = try? NSAttributedString(data: data, options: [
                .documentType: NSAttributedString.DocumentType.html, .characterEncoding: NSNumber(value: String.Encoding.utf8.rawValue)
            ], documentAttributes: nil)
        }
        return self
    }

    @discardableResult
    public func text(_ value: String?) -> Self { invoke { self.text = value } }

    @discardableResult
    func text(align: NSTextAlignment) -> Self { invoke { self.textAlignment = align } }

    @discardableResult
    func text(color: UIColor) -> Self { invoke { self.textColor = textColor } }

    @discardableResult
    func font(_ font: UIFont) -> Self { invoke { self.font = font } }

    @discardableResult
    func font(size: CGFloat) -> Self { invoke { self.fontSize = size } }

    var fontSize: CGFloat {
        get { font!.fontDescriptor.pointSize }
        set { font = font!.withSize(newValue) }
    }

    @discardableResult
    func font(style: UIFont.TextStyle) -> Self { invoke { self.fontStyle = style } }

    var fontStyle: UIFont.TextStyle {
        get { font!.fontDescriptor.object(forKey: .textStyle) as! UIFont.TextStyle }
        set { font = UIFont.preferredFont(forTextStyle: newValue) }
    }
}