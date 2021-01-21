//
// Created by Rene Dohan on 1/11/20.
//

import Foundation

public protocol CSHasProgressProtocol {
    func show(progress title: String, cancel: CSDialogAction?) -> CSHasDialogVisible
}

public extension CSHasProgressProtocol {
    func show(progress title: String, onCancel: Func? = nil) -> CSHasDialogVisible {
        show(progress: title, cancel: onCancel.notNil ?
                CSDialogAction(title: .cs_dialog_cancel, action: onCancel!) : nil)
    }
}
