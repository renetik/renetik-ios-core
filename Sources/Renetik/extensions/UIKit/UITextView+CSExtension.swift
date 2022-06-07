import UIKit

public enum CSVerticalAlign { case top; case center; case bottom }

let labelForDefaultFont = UILabel()

public class AssociatedUITextViewDelegate: NSObject, UITextViewDelegate {
    let textViewDidChange: CSEvent<Void> = event()

    public func textViewDidChange(_ textField: UITextView) {
        textViewDidChange.fire()
    }
}

public extension UITextView {

    var associatedDelegate: AssociatedUITextViewDelegate {
        associated("associatedDelegate") { AssociatedUITextViewDelegate().also { delegate = $0 } }
    }

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
    func textVertical(align: CSVerticalAlign) -> Self {
        switch align {
        case .top: alignContentTop()
        case .center: alignContentCenter()
        case .bottom: alignContentBottom()
        }
        return self;
    }

    @discardableResult
    func alignContentCenter() -> Self {
        let usedRect = layoutManager.usedRect(for: textContainer)
        let topInset = (bounds.size.height - usedRect.height) / 2.0
        textContainerInset.top = max(0, topInset)
        return self
    }

    @discardableResult
    func alignContentBottom() -> Self {
        let usedRect = layoutManager.usedRect(for: textContainer)
        let topInset = bounds.size.height - usedRect.height
        textContainerInset.top = max(0, topInset)
        return self
    }

    @discardableResult
    func alignContentTop() -> Self {
        textContainerInset.top = 0
        return self
    }

    @discardableResult
    override func onTap(_ block: @escaping Func) -> Self {
        isEditable = false
        isSelectable = false
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
    func onTextChange(_ function: @escaping ArgFunc<UITextView>) -> Self {
        associatedDelegate.textViewDidChange.listen { function(self) }; return self
//        bk_didChangeBlock = { _ in function(self) }; return self
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
        font(labelForDefaultFont.font)
        textContainer.lineBreakMode = .byTruncatingTail
        return self
    }

    @discardableResult
    func text(align: NSTextAlignment) -> Self { invoke { textAlignment = align } }
}

extension UITextView: CSHasTextProtocol {
    public func text() -> String? { text }

    public func text(_ text: String?) { self.text = text }
}

extension UITextView: CSHasFontProtocol {
    public func font() -> UIFont? { font }

    public func font(_ font: UIFont?) { self.font = font }
}
