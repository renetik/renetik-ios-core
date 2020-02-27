//
// Created by Rene Dohan on 1/25/20.
//

import UIKit
import RenetikObjc
import BlocksKit

public struct CSTextViewClearButtonAppearance {
    fileprivate let titleColor: UIColor?

    public init(titleColor: UIColor) {
        self.titleColor = titleColor
    }
}

public extension UITextView {

    @discardableResult
    func dataDetector(_ types: UIDataDetectorTypes) -> Self {
        dataDetectorTypes = types
        if types.isEmpty { isSelectable = true }
        return self
    }

    @discardableResult
    override public func onTap(_ block: @escaping () -> Void) -> Self {
        self.isEditable = false
        self.isSelectable = false
        super.onTap(block)
        return self
    }

    @discardableResult
    func withClear(_ parent: CSViewController, _ appearance: CSTextViewClearButtonAppearance? = nil) -> Self {
        let button = UIButton(type: .system).construct().text("X").fontStyle(.body)
                .visible(if: self.text.isSet).onClick { self.text = "" }
        add(button).from(left: 5).resizeToFit().centerInParentHorizontal()
        //TODO: Clear button its moving as text exceed space
        onTextChange(in: parent) { _ in button.visible(if: self.text.isSet) }
        appearance?.titleColor?.then { color in button.textColor(color) }
        return self
    }

    @discardableResult
    public func text(_ value: String) -> Self {
        text = value
        return self
    }

    @discardableResult
    func onTextChange(in parent: CSViewController, _ function: @escaping (UITextView) -> Void) -> Self {
        parent.observe(notification: UITextView.textDidChangeNotification) { notification in
            if (notification.object as! NSObject) === self { function(self) }
        }
        return self
    }


}