//
// Created by Rene Dohan on 12/22/19.
// Copyright (c) 2019 Renetik Software. All rights reserved.
//

import Foundation
import UIKit
import Renetik
import RenetikObjc
import UITextView_Placeholder

public protocol CSHasInputAccessory: NSObjectProtocol {
    var inputAccessoryView: UIView? { get set }
}

public protocol CSHasUIResponder: NSObjectProtocol {
    var responder: UIResponder { get }
}

public protocol CSHasTextInput: NSObjectProtocol {
    var textInput: UITextInput? { get set }
}

extension UITextView: CSHasInputAccessory {}

public class CSTextInputPhoneLandscapeController: CSViewController {

    private let keyboardManager = CSKeyboardManager()
    public let container = UIView.withSize(100, 50).background(.white)
    public let textView = UITextView.construct().background(.white)
    public let doneButton = UIButton.construct().textColor(.blue)
    private var parentTextInput: (CSHasTextProtocol & CSHasUIResponder)!
    private var hasAccessory: CSHasInputAccessory?
    private var accessoryTextInput: UITextInput?

    @discardableResult
    public func construct(by parent: CSViewController, textInput: CSHasTextProtocol & CSHasUIResponder,
                          hasAccessory: CSHasInputAccessory? = nil,
                          doneTitle: String = "Done", placeHolder: String = "Enter text") -> Self {
        constructAsViewLess(in: parent)
        self.parentTextInput = textInput
        self.hasAccessory = hasAccessory
        accessoryTextInput = (hasAccessory?.inputAccessoryView as? CSHasTextInput)?.textInput
        doneButton.text = doneTitle
        textView.placeholder = placeHolder
        keyboardManager.construct(self) { _ in self.onKeyboardChange() }
        doneButton.onClick(onDoneClick)
        return self
    }


    override public func onCreateLayout() {
        super.onCreateLayout()
        container.add(view: doneButton.resizeToFit()).from(right: 5).centerInParentVertical()
        container.add(view: textView).matchParent(margin: 5).width(from: doneButton, right: 5)
    }

    override public func onViewDidLayout() {
        super.onViewDidLayout()
        self.updateVisibility()
    }

    private func onKeyboardChange() {
        if parentTextInput.responder.isFirstResponder && UIScreen.isShort {
            textView.text = parentTextInput.text
            changeAccessory(from: hasAccessory, to: textView, textInput: textView)
            delegate.window!.add(view: container).matchParent()
            textView.becomeFirstResponder()
            return
        }
        if textView.isFirstResponder && UIScreen.isShort {
            container.height(fromBottom: keyboardManager.keyboardHeight)
            return
        }
        updateVisibility()
    }

    private func updateVisibility() {
        if !UIScreen.isShort && isActive { hide() }
        if !textView.isFirstResponder && isActive { hide() }
    }

    private func hide() {
        parentTextInput.text = textView.text
        changeAccessory(from: textView, to: hasAccessory, textInput: accessoryTextInput)
        container.removeFromSuperview()
        textView.resignFirstResponder()
    }

    private func changeAccessory(from hasAccessory1: CSHasInputAccessory?,
                                 to hasAccessory2: CSHasInputAccessory?,
                                 textInput: UITextInput?) {
        let accessoryView = hasAccessory1?.inputAccessoryView
        textInput.notNil { input in (accessoryView as? CSHasTextInput)?.textInput = input }
        hasAccessory2?.inputAccessoryView = accessoryView
    }

    private var isActive: Bool { container.superview.notNil }

    private func onDoneClick() { textView.resignFirstResponder() }

}
