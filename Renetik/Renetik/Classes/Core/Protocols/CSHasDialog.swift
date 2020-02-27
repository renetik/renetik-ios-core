//
// Created by Rene Dohan on 1/11/20.
//

import Foundation

public protocol CSHasDialogVisible {
    var isDialogVisible: Bool { get }
    func hideDialog(animated: Bool)
}

public extension CSHasDialogVisible {
    func hideDialog() { hideDialog(animated: true) }
}

public struct CSDialogAction {
    public let title: String?, action: () -> Void

    public init(action: @escaping () -> Void) {
        self.title = nil
        self.action = action
    }

    public init(title: String?, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    public func run() { action() }
}

public protocol CSHasDialog {
    @discardableResult
    func show(title: String?, message: String,
              positive: CSDialogAction?, negative: CSDialogAction?,
              cancel: CSDialogAction?) -> CSHasDialogVisible
}

public extension CSHasDialog {
    @discardableResult
    public func show(message: String,
                     positiveTitle: String = CSStrings.dialogYes,
                     onPositive: (() -> Void)? = nil,
                     onCanceled: (() -> Void)? = nil,
                     canCancel: Bool = true) -> CSHasDialogVisible {
        show(title: nil, message: message,
                positive: CSDialogAction(title: positiveTitle, action: onPositive ?? {}),
                negative: nil, cancel: canCancel ? CSDialogAction(action: onCanceled ?? {}) : nil)
    }


    @discardableResult
    public func show(title: String? = nil, message: String,
                     positive: CSDialogAction?, negative: CSDialogAction? = nil) -> CSHasDialogVisible {
        show(title: title, message: message, positive: positive,
                negative: negative, cancel: nil)
    }

}
