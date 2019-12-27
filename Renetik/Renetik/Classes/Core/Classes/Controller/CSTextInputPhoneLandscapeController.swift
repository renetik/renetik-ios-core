//
// Created by Rene Dohan on 12/22/19.
// Copyright (c) 2019 Renetik Software. All rights reserved.
//

import Foundation
import UIKit
import Renetik
import RenetikObjc
import UITextView_Placeholder

public protocol CSHasInputAccessory {
    var inputAccessoryView: UIView? { get set }
}

public protocol CSHasTextInput: NSObjectProtocol {
    var textInput: UITextInput { get set }
}

public class CSTextInputPhoneLandscapeController: CSViewController {

    private let keyboardManager = CSKeyboardManager()
    public let container = UIView.withSize(100, 50).background(.lightGray)
    public let textView = UITextView.construct().background(.white)
    public let doneButton = UIButton.construct().titleColor(.black)
    private var parentTextInput: CSHasTextProtocol!
    private var hasInputAccessory: CSHasInputAccessory?
    private var inputAccessoryTextInput: UITextInput?

    @discardableResult
    public func construct(by parent: CSViewController, textInput: CSHasTextProtocol,
                          hasInputAccessory: CSHasInputAccessory? = nil,
                          doneTitle: String = "Done", placeHolder: String = "Enter text") -> Self {
        constructAsViewLess(in: parent)
        self.parentTextInput = textInput
        self.hasInputAccessory = hasInputAccessory
        inputAccessoryTextInput = (hasInputAccessory?.inputAccessoryView as? CSHasTextInput)?.textInput
        doneButton.text = doneTitle
        textView.placeholder = placeHolder
        keyboardManager.construct(self) { _ in self.updateVisibility() }
        doneButton.onClick(onDoneClick)
        return self
    }

    override public func onCreateLayout() {
        super.onCreateLayout()
        container.add(view: doneButton.sizeFit()).from(right: 5).centerInParentVertical()
        container.add(view: textView).matchParent(margin: 5)
                .width(fromRight: doneButton.leftFromRight + 5)
    }

    override public func onViewDidLayout() {
        super.onViewDidLayout()
        self.updateVisibility()
    }

    private func updateVisibility() {
        if UIScreen.isShort && keyboardManager.isKeyboardVisible {
            if isActive { return }
            textView.text = parentTextInput.text
            textView.inputAccessoryView = hasInputAccessory?.inputAccessoryView
            (textView.inputAccessoryView as? CSHasTextInput)?.textInput = textView
            delegate.window!.add(view: container).matchParent()
                    .height(fromBottom: keyboardManager.keyboardHeight)
            textView.becomeFirstResponder()
        }
        else if isActive {
            parentTextInput.text = textView.text
            hasInputAccessory?.inputAccessoryView = textView.inputAccessoryView
            inputAccessoryTextInput.notNil { (textView.inputAccessoryView as? CSHasTextInput)?.textInput = $0 }
            container.removeFromSuperview()
            textView.resignFirstResponder()
        }
    }

    private var isActive: Bool { container.superview.notNil }

    private func onDoneClick(view: UIView) { textView.resignFirstResponder() }

}
