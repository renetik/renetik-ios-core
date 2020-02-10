//
// Created by Rene Dohan on 1/25/20.
//

import UIKit
import RenetikObjc
import BlocksKit

public struct CSTextViewClearButtonAppearance: CSAny {
    var titleColor: UIColor?
}

public extension UITextView {

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
        add(button).from(left: 5).resizeToFit().centerInParentVertical()
        onChange(parent) { _ in button.visible(if: self.text.isSet) }
        appearance?.titleColor?.then { color in button.textColor(color) }
        return self
    }

    @discardableResult
    public func text(_ value: String) -> Self {
        text = value
        return self
    }

    @discardableResult
    func onChange(_ parent: CSViewController, _ function: @escaping (UITextView) -> Void) -> Self {
        let observer = NotificationCenter.add(observer: UITextView.textDidChangeNotification) { it in
            if (it.object as! NSObject) === self { function(self) }
        }
        parent.eventDismissing.invoke {
            NotificationCenter.remove(observer: observer)
        }
        return self
    }


}