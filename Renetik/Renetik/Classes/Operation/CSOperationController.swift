//
// Created by Rene Dohan on 12/30/19.
// Copyright (c) 2019 Bowbook. All rights reserved.
//

import Foundation
import Renetik

public protocol CSOperationController {
    @discardableResult
    func send<Data>(_ operation: CSOperation<Data>, _ progress: Bool,
                    _ failedDialog: Bool, _ onSuccess: ((Data) -> Void)?) -> CSProcess<Data>
}

public extension CSOperationController {

    @discardableResult
    func send<Data>(operation: CSOperation<Data>, progress: Bool = true,
                    failedDialog: Bool = true, onSuccess: ((Data) -> Void)? = nil) -> CSProcess<Data> {
//        let process = operation.send()
//        if progress {
//            let progress = show(progress: operation.title, onCancel: { operation.cancel() })
//            process.onDone { _ in progress.hide() }
//        }
//        if failedDialog {
//            process.onFailed { _ in
//                self.show(title: operation.title, message: CSStrings.sendRequestFailed,
//                        positive: CSDialogAction(title: CSStrings.sendRequestRetry) {
//                            self.send(operation: operation, progress: progress,
//                                    failedDialog: failedDialog, onSuccess: onSuccess)
//                        },
//                        negative: CSDialogAction(title: CSStrings.sendRequestCancel) { operation.cancel() })
//            }
//        }
//        onSuccess.isNotNil { operation.onSuccess($0) }
        send(operation, progress, failedDialog, onSuccess)
    }
}