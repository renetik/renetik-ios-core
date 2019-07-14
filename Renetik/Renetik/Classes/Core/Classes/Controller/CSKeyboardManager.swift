//
//  CSKeyboardManager.swift
//  Renetik
//
//  Created by Rene Dohan on 7/9/19.
//

import RenetikObjc

public class CSKeyboardManager: CSChildViewLessController {
    public var keyboardHeight: CGFloat = 0
    public var onKayboardChange: ((CGFloat) -> Void)?
    public var isKeyboardVisible: Bool { return keyboardHeight > 0 }

	@discardableResult
    public func construct(
        _ parent: UIViewController,
        _ onKayboardChange: ((CGFloat) -> Void)? = nil) -> Self {
        super.construct(parent)
        self.onKayboardChange = onKayboardChange
        observer(UIResponder.keyboardDidShowNotification, keyboardDidShow)
        observer(UIResponder.keyboardDidHideNotification, keyboardDidHide)
        return self
    }

    func keyboardDidShow(_ note: Notification) {
        let rect =
            note.userInfo![UIResponder.keyboardFrameEndUserInfoKey]
            as! CGRect
        keyboardHeight = rect.size.height
        onKayboardChange?(keyboardHeight)
    }

    func keyboardDidHide(_ note: Notification) {
        keyboardHeight = 0
        onKayboardChange?(0)
    }
}
