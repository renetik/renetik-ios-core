//
// Created by Rene Dohan on 1/25/20.
//

import UIKit

public extension UITextView {

//    class func construct(_ text: String) -> Self { construct().text(text) }
//
//    class func construct(text: String) -> Self { construct().text(text) }

    func delegate(_ delegate: UITextViewDelegate) -> Self { self.delegate = delegate; return self }

    func scrollToCursorPosition() -> Self {
        later(seconds: 0.1) {
            if let start = self.selectedTextRange?.start {
                self.scrollRectToVisible(self.caretRect(for: start), animated: true)
            }
        }
        return self
    }

    @discardableResult
    func detectData(_ types: UIDataDetectorTypes = [.all]) -> Self {
        dataDetectorTypes = types
        if types.isEmpty { isSelectable = true }
        return self
    }

    @discardableResult
    func detect(data: UIDataDetectorTypes) -> Self { detectData(data) }

    @discardableResult
    func detect(_ data: UIDataDetectorTypes) -> Self { detectData(data) }

    @discardableResult
    override public func onTap(_ block: @escaping Func) -> Self {
        self.isEditable = false
        self.isSelectable = false
        super.onTap(block)
        return self
    }

//    @discardableResult
//    func onTextChange(in parent: CSViewController, _ function: @escaping ArgFunc<UITextView>) -> Self {
//        parent.observe(notification: UITextView.textDidChangeNotification) { notification in
//            if (notification.object as! NSObject) === self { function(self) }
//        }
//        return self
//    }

    @discardableResult
    public func onTextChange(_ function: @escaping ArgFunc<UITextView>) -> Self {
        bk_didChangeBlock = { _ in function(self) }; return self
    }

    @discardableResult
    func heightToFit(lines numberOfLines: Int) -> Self {
        let currentWidth = width; let currentText = text; var linesText = "line"
        for i in 0..<numberOfLines - 1 {
            linesText += "\n line"
        }
        text(linesText).resizeToFit().text(currentText).width(currentWidth)
        return self
    }

    @discardableResult
    func asLabel() -> Self {
        textContainerInset = .zero
        contentInset = .zero
        isEditable = false
        isScrollEnabled = false
        backgroundColor = .clear
        contentInsetAdjustmentBehavior = .never
        textContainer.lineFragmentPadding = 0
        layoutManager.usesFontLeading = false
        return self
    }

    @discardableResult
    func text(align: NSTextAlignment) -> Self { invoke { self.textAlignment = align } }
}

extension UITextView: CSHasTextProtocol {
    public func text() -> String? { text }

    public func text(_ text: String?) { self.text = text }
}

extension UITextView: CSHasFontProtocol {
    public func font() -> UIFont? { font }

    public func font(_ font: UIFont?) { self.font = font }
}