//
// Created by Rene Dohan on 1/11/20.
//

import Foundation

public protocol CSHasDialogVisible {
    var isVisible: Bool { get }
    func hide(animated: Bool)
}

public extension CSHasDialogVisible {
    func hide() { hide(animated: true) }
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
                     onCanceled: (() -> Void)? = nil) -> CSHasDialogVisible {
        show(title: nil, message: message,
                positive: CSDialogAction(title: positiveTitle, action: onPositive ?? {}),
                negative: nil, cancel: CSDialogAction(action: onCanceled ?? {}))
    }


    @discardableResult
    public func show(title: String?, message: String,
                     positive: CSDialogAction?, negative: CSDialogAction?) -> CSHasDialogVisible {
        show(title: title, message: message, positive: positive,
                negative: negative, cancel: CSDialogAction(action: {}))
    }

}
