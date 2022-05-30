//
// Created by Rene Dohan on 1/11/20.
//

import Foundation

public protocol CSHasDialogVisible: class {
    var isDialogVisible: Bool { get }
    func hideDialog(animated: Bool)
}

public extension CSHasDialogVisible {
    func hideDialog() { hideDialog(animated: true) }
}

public struct CSDialogAction {
    public let title: String?, action: Func

    public init(action: @escaping Func) {
        self.title = nil
        self.action = action
    }

    public init(title: String?, action: @escaping Func) {
        self.title = title
        self.action = action
    }
}

public protocol CSHasDialogProtocol {
    @discardableResult
    func show(title: String?, message: String,
              positive: CSDialogAction?, negative: CSDialogAction?,
              cancel: CSDialogAction?) -> CSHasDialogVisible
}

public extension CSHasDialogProtocol {
    @discardableResult
    public func show(message: String,
                     positiveTitle: String = .cs_dialog_ok,
                     onPositive: Func? = nil,
                     onCanceled: Func? = nil,
                     canCancel: Bool = true) -> CSHasDialogVisible {
        show(title: nil, message: message,
                positive: CSDialogAction(title: positiveTitle, action: onPositive ?? {}),
                negative: nil, cancel: canCancel ? CSDialogAction(action: onCanceled ?? {}) : nil)
    }

    @discardableResult
    public func show(message: String, onPositive: Func? = nil) -> CSHasDialogVisible {
        show(message: message, positiveTitle: .cs_dialog_ok, onPositive: onPositive)
    }

    @discardableResult
    public func show(title: String? = nil, message: String,
                     positive: CSDialogAction?, negative: CSDialogAction? = nil) -> CSHasDialogVisible {
        show(title: title, message: message, positive: positive,
                negative: negative, cancel: nil)
    }
}
