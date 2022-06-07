//
// Created by Rene Dohan on 1/11/20.
//

import Foundation

public protocol CSHasProgressProtocol {
    func show(progress title: String, _ cancel: CSDialogAction?,
              _ graceTime: TimeInterval?, _  minShowTime: TimeInterval?) -> CSHasDialogVisible
}

public extension CSHasProgressProtocol {
    func show(progress title: String, onCancel: Func? = nil,
              graceTime: TimeInterval = 0, minShowTime: TimeInterval = 2) -> CSHasDialogVisible {
        show(progress: title, onCancel.notNil ?
                CSDialogAction(title: .cs_dialog_cancel, action: onCancel!) : nil, graceTime, minShowTime)
    }

    func show(progress title: String, cancel: CSDialogAction?,
              graceTime: TimeInterval = 0, minShowTime: TimeInterval = 2) -> CSHasDialogVisible {
        show(progress: title, cancel, graceTime, minShowTime)
    }
}
