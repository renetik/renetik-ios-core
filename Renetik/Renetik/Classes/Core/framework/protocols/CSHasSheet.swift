//
// Created by Rene Dohan on 1/11/20.
//

import UIKit

public protocol CSHasSheetProtocol {
    @discardableResult
    func show(title: String?, message: String?, actions: [CSDialogAction]?, positive: CSDialogAction?,
              cancel: CSDialogAction?, from: CSDisplayElement) -> CSHasDialogVisible
}

public extension CSHasSheetProtocol {
    @discardableResult
    func show(actions: [CSDialogAction], from: CSDisplayElement) -> CSHasDialogVisible {
        show(title: nil, message: nil, actions: actions, positive: nil,
                cancel: CSDialogAction(title: .cs_dialog_cancel, action: {}), from: from)
    }

    @discardableResult
    func show(actions: [CSDialogAction], from view: UIView) -> CSHasDialogVisible {
        show(actions: actions, from: CSDisplayElement(view: view))
    }

    @discardableResult
    func show(actions: [CSDialogAction], from item: UIBarButtonItem) -> CSHasDialogVisible {
        show(actions: actions, from: CSDisplayElement(item: item))
    }

    @discardableResult
    func show(actions: CSDialogAction..., from view: UIView) -> CSHasDialogVisible {
        show(actions: actions, from: view)
    }

    @discardableResult
    func show(actions: CSDialogAction..., from item: UIBarButtonItem) -> CSHasDialogVisible {
        show(actions: actions, from: item)
    }
}