//
// Created by Rene Dohan on 12/14/19.
// Copyright (c) 2019 Renetik Software. All rights reserved.
//

import Foundation
import UIKit
import Renetik
import RenetikObjc
import MaterialComponents
import MaterialComponents.MDCTextInputControllerBase

extension MDCTextInputControllerBase: CSHasTextProtocol, CSHasUIResponder {

    public var responder: UIResponder { textInput! }

    @objc public var view: MDCBaseTextField { textInput as! MDCBaseTextField }

    @discardableResult
    public func error(_ message: String? = nil) -> Self {
        setErrorText(message ?? "", errorAccessibilityValue: nil)
        return self
    }

    @discardableResult
    public func errorClear() -> Self {
        setErrorText(nil, errorAccessibilityValue: nil)
        return self
    }

    public var isError: Bool { errorText != nil }

    @discardableResult
    public func keyboard(_ type: UIKeyboardType) -> Self {
        view.keyboardType = type
        return self
    }

    public func text() -> String? { view.text }

    public func text(_ text: String?) { view.text = text }

    public var isEnabled: Bool {
        get { view.isEnabled }
        set(value) { view.isEnabled = value }
    }

    @discardableResult
    public func onClick(_ function: @escaping (MDCBaseTextField) -> Void) -> Self {
        textInput!.onClick { function(self.view) }
        return self
    }

    @discardableResult
    public func onTextChange(_ function: @escaping (MDCBaseTextField) -> Void) -> Self {
        view.onTextChange { _ in function(self.view) }
        return self
    }

    @discardableResult
    public func onClear(_ function: @escaping (MDCBaseTextField) -> Void) -> Self {
        view.onClear { function(self.view) }
        return self
    }
}

extension MDCTextInputControllerOutlined {
    @objc override public var view: MDCOutlinedTextField { textInput as! MDCOutlinedTextField }
}