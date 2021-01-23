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
    @objc override open func onClick(_ function: @escaping Func) -> Self {
        bk_shouldBeginEditingBlock = { _ in function(); return false }
        return self
    }

    @discardableResult
    func onBeginEditing(_ function: @escaping () -> Bool) -> Self {
        bk_shouldBeginEditingBlock = { _ in function() }
        return self
    }

    @discardableResult
    func onEndEditing(_ function: @escaping () -> Bool) -> Self {
        bk_shouldEndEditingBlock = { _ in function() }
        return self
    }

    @discardableResult
    func onChange(_ function: @escaping ArgFunc<UITextField>) -> Self {
        bk_addEventHandler({ _ in function(self) }, for: .editingChanged)
        return self
    }

    private var eventTextChangeKey: String { "UITextField+eventTextChange" }
    private var eventTextChange: CSEvent<Void> { associatedDictionary(eventTextChangeKey) { event() } }
    private var isEventTextChangeRegistered: Bool { associatedDictionary[eventTextChangeKey] != nil }

    @discardableResult
    func onTextChange(_ function: @escaping ArgFunc<UITextField>) -> Self {
        if !isEventTextChangeRegistered {
            func onChange() {
                if text != associatedDictionary[previousTextKey] as? String {
                    associatedDictionary[previousTextKey] = text
                    eventTextChange.fire()
                }
            }

            bk_addEventHandler({ _ in onChange() }, for: .editingChanged)
            bk_addEventHandler({ _ in onChange() }, for: .editingDidEnd)
            bk_addEventHandler({ _ in onChange() }, for: .editingDidEndOnExit)
            bk_addObserver(forKeyPath: "text") { _ in onChange() }
        }
        eventTextChange.listen { function(self) }
        return self
    }

    @discardableResult
    func onTextChange(_ function: @escaping Func) -> Self {
        onTextChange { _ in function() }
    }

    @discardableResult
    @objc func onClear(_ function: @escaping Func) -> Self {
        bk_shouldClearBlock = { _ in
            function()
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

    public var title: String {
        get { text ?? "" }
        set { text = newValue }
    }

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

    @discardableResult
    func filter(_ filter: CSInputFilterProtocol) -> Self {
        bk_shouldChangeCharactersInRangeWithReplacementStringBlock = { field, range, string in
            if string.isNilOrEmpty { return true }
            return filter.filter(current: self.text ?? "", range: range, string: string!)
        }
        return self
    }

    @discardableResult
    func filters(_ filters: CSInputFilterProtocol...) -> Self {
        filters.forEach { filter($0) }
        return self
    }

    @discardableResult
    func keyboard(_ type: UIKeyboardType) -> Self { keyboardType = type; return self }

    @discardableResult
    func max(length: Int) -> Self { filters(CSIntMaxLengthInputFilter(length)); return self }
}

