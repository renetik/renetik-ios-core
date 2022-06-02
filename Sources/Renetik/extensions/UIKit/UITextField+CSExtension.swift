//
// Created by Rene Dohan on 1/4/20.
//

import UIKit

public class AssociatedUITextFieldDelegate: NSObject, UITextFieldDelegate {
    let textFieldShouldBeginEditing: CSEvent<Void> = event()
    var onTextFieldShouldBeginEditing: (() -> Bool)? = nil

    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textFieldShouldBeginEditing.fire()
        return onTextFieldShouldBeginEditing?() ?? true
    }

    let textFieldDidBeginEditing: CSEvent<Void> = event()

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldDidBeginEditing.fire()
    }

    let textFieldShouldEndEditing: CSEvent<Void> = event()
    var onTextFieldShouldEndEditing: (() -> Bool)? = nil

    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textFieldShouldEndEditing.fire()
        return onTextFieldShouldEndEditing?() ?? true
    }

    let textFieldDidEndEditing: CSEvent<UITextField.DidEndEditingReason> = event()

    public func textFieldDidEndEditing(_ textField: UITextField,
                                       reason: UITextField.DidEndEditingReason) {
        textFieldDidEndEditing.fire(reason)
    }

    var onShouldChangeCharactersIn: ((_ range: NSRange, _ replacement: String) -> Bool)? = nil

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        onShouldChangeCharactersIn?(range, string) ?? true
    }

    let textFieldDidChangeSelection: CSEvent<Void> = event()

    public func textFieldDidChangeSelection(_ textField: UITextField) {
        textFieldDidChangeSelection.fire()
    }

    let textFieldShouldClear: CSEvent<Void> = event()
    var onTextFieldShouldClear: (() -> Bool)? = nil

    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textFieldShouldClear.fire()
        return onTextFieldShouldClear?() ?? true
    }
}

public extension UITextField {

    var associatedDelegate: AssociatedUITextFieldDelegate {
        associated("associatedDelegate") { AssociatedUITextFieldDelegate().also { delegate = $0 } }
    }

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
        associatedDelegate.onTextFieldShouldBeginEditing = { function(); return false }
//        bk_shouldBeginEditingBlock = { _ in function(); return false }
        return self
    }

    @discardableResult
    func onBeginEditing(_ function: @escaping () -> Bool) -> Self {
//        associatedDelegate.textFieldShouldBeginEditing.listen { function() }
        associatedDelegate.onTextFieldShouldBeginEditing = function
//        bk_shouldBeginEditingBlock = { _ in function() }
        return self
    }

    @discardableResult
    func onEndEditing(_ function: @escaping () -> Bool) -> Self {
//        associatedDelegate.textFieldShouldEndEditing.listen { function() }
        associatedDelegate.onTextFieldShouldEndEditing = function
//        bk_shouldEndEditingBlock = { _ in function() }
        return self
    }

    @discardableResult
    func onChange(_ function: @escaping Func) -> Self {
        addEventHandler(controlEvents: .editingChanged) { function() }
        return self
    }

    private static let eventTextChangeKey = "UITextField+CSExtension.swift:eventTextChange"
    private var eventTextChange: CSEvent<Void> { associated(UITextField.eventTextChangeKey) { event() } }
    private var isEventTextChangeRegistered: Bool { associatedDictionary[UITextField.eventTextChangeKey] != nil }
    private static let previousTextKey = "UITextField+CSExtension.swift:onTextChange:PreviousText"

    @discardableResult
    func onTextChange(_ function: @escaping ArgFunc<UITextField>) -> Self {
        if !isEventTextChangeRegistered {
            func onChange() {
                if text != associatedDictionary[UITextField.previousTextKey] as? String {
                    associatedDictionary[UITextField.previousTextKey] = text
                    eventTextChange.fire()
                }
            }

            addEventHandler(controlEvents: .editingChanged) { onChange() }
            addEventHandler(controlEvents: .editingDidEnd) { onChange() }
            addEventHandler(controlEvents: .editingDidEndOnExit) { onChange() }
//            bk_addObserver(forKeyPath: "text") { _ in onChange() }
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
        associatedDelegate.onTextFieldShouldClear = { function(); return true }
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
    func text(align: NSTextAlignment) -> Self { invoke { self.textAlignment = align } }

    @discardableResult
    @objc func text(color: UIColor) -> Self { invoke { self.textColor = textColor } }

    @discardableResult
    func font(_ font: UIFont) -> Self { invoke { self.font = font } }

    @discardableResult
    func font(size: CGFloat) -> Self { invoke { self.fontSize = size } }

    var fontSize: CGFloat {
        get { font!.fontDescriptor.pointSize }
        set { font = font!.withSize(newValue) }
    }

    @discardableResult
    func font(style: UIFont.TextStyle) -> Self { invoke { fontStyle = style } }

    var fontStyle: UIFont.TextStyle {
        get { font!.fontDescriptor.object(forKey: .textStyle) as! UIFont.TextStyle }
        set { font = UIFont.preferredFont(forTextStyle: newValue) }
    }

    var filters: CSArray<CSInputFilterProtocol> {
        associated("UITextField+filters") {
            let filters = CSArray<CSInputFilterProtocol>()
            associatedDelegate.onShouldChangeCharactersIn = { range, string in
                if string.isEmpty { return true }
                for filter in filters.asArray {
                    if !filter.filter(current: self.text ?? "", range: range, string: string) { return false }
                }
                return true
            }
            return filters
        }
    }

    @discardableResult
    func filters(_ filters: CSInputFilterProtocol...) -> Self {
        for filter in filters { self.filters.add(filter) }; return self
    }

    @discardableResult
    func keyboard(_ type: UIKeyboardType) -> Self { keyboardType = type; return self }

    @discardableResult
    func max(length: Int) -> Self { filters(CSIntMaxLengthInputFilter(length)); return self }

    func secure() -> Self { isSecureTextEntry = true; return self }
}

extension UITextField: CSHasTextProtocol {
    public func text() -> String? { text }

    public func text(_ text: String?) { self.text = text }
}

class CSControlWrapper: NSObject {
    init(_ function: @escaping Func, _ controlEvents: UIControl.Event) {
        self.function = function; self.controlEvents = controlEvents
    }

    let function: Func
    let controlEvents: UIControl.Event

    @objc func invoke(sender: UIControl) { function() }
}

extension UIControl {
    func addEventHandler(controlEvents: Event, _ function: @escaping Func) {
        let events: NSMutableDictionary = associated("controlEvents") { NSMutableDictionary() }
        let handlers: NSMutableSet = events.value(forKey: "\(controlEvents.rawValue)") { NSMutableSet() }
        let target = CSControlWrapper(function, controlEvents)
        handlers.add(target)
        addTarget(target, action: #selector(CSControlWrapper.invoke(sender:)), for: controlEvents)
    }

    func removeEventHandler(controlEvents: UIControl.Event) {
        let events: NSMutableDictionary = associated("controlEvents") { NSMutableDictionary() }
        let key = "\(controlEvents.rawValue)"
        let handlers: NSMutableSet? = events.value(forKey: key) as? NSMutableSet
        if handlers == nil { return }
        handlers?.forEach { element in removeTarget(element, action: nil, for: controlEvents) }
        events.removeObject(forKey: key)
    }
}

extension NSMutableDictionary {
    func value<T>(forKey key: String, onCreate: () -> T) -> T {
        var value = value(forKey: key) as? T
        if (value == nil) {
            value = onCreate()
            setValue(value, forKey: key)
        }
        return value!
    }
}
