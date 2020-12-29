//
//  CSKeyboardManager.swift
//  Renetik
//
//  Created by Rene Dohan on 7/9/19.
//

import UIKit

public class CSKeyboardObserverController: CSViewController {
    public var keyboardHeight: CGFloat = 0
    public var onKeyboardChange: ((CGFloat) -> Void)?
    public var onKeyboardShow: CSEvent<CGFloat> = event()
    public var onKeyboardHide = event()
    public var isKeyboardVisible: Bool { keyboardHeight > 0 }

    @discardableResult
    public func construct(
            _ parent: UIViewController,
            _ onKeyboardChange: ((_ keyboardHeight: CGFloat) -> Void)? = nil) -> Self {
        super.construct(parent).asViewLess()
        self.onKeyboardChange = onKeyboardChange
        observe(notification: UIResponder.keyboardDidShowNotification, callback: keyboardDidShow)
        observe(notification: UIResponder.keyboardDidHideNotification, callback: keyboardDidHide)
        return self
    }

    private func keyboardDidShow(_ note: Notification) {
        let rect = note.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        keyboardHeight = rect.size.height
        onKeyboardShow.fire(keyboardHeight)
        onKeyboardChange?(keyboardHeight)
    }

    private func keyboardDidHide(_ note: Notification) {
        keyboardHeight = 0
        onKeyboardHide.fire()
        onKeyboardChange?(0)
    }
}
