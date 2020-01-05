//
// Created by Rene Dohan on 12/30/19.
// Copyright (c) 2019 Bowbook. All rights reserved.
//

import Foundation
import Renetik

public extension CSHasDialogController {
    @discardableResult
    func send<Data: CSAny>(operation: CSOperation<Data>, progress: Bool = true, onSuccess: ((Data) -> Void)? = nil) -> CSProcess<Data> {
        progress ? sendWithProgress(operation: operation, onSuccess: onSuccess) : sendWithFailedDialog(operation: operation)
    }

    @discardableResult
    func sendWithProgress<Data: CSAny>(operation: CSOperation<Data>, onSuccess: ((Data) -> Void)? = nil) -> CSProcess<Data> {
        let process = operation.send()

        let progress = dialog(operation.title).showProgress(onCancel: { _ in operation.cancel() })

        process.onFailed { _ in
            self.dialog(operation.title, CSStrings.sendRequestFailed)
                    .show(positiveTitle: CSStrings.sendRequestRetry,
                            positiveAction: { self.sendWithProgress(operation: operation, onSuccess: onSuccess) },
                            negativeTitle: CSStrings.sendRequestCancel,
                            negativeAction: { operation.cancel() })
        }.onDone { _ in progress.hide() }

        onSuccess.notNil { operation.onSuccess($0) }
        return process
    }

    @discardableResult
    func sendWithFailedDialog<Data: CSAny>(operation: CSOperation<Data>, onSuccess: ((Data) -> Void)? = nil) -> CSProcess<Data> {
        let process = operation.send().onFailed { _ in
            self.dialog(operation.title, CSStrings.sendRequestFailed)
                    .show(positiveTitle: CSStrings.sendRequestRetry,
                            positiveAction: { self.sendWithFailedDialog(operation: operation) },
                            negativeTitle: CSStrings.sendRequestCancel,
                            negativeAction: { operation.cancel() })
        }
        onSuccess.notNil { operation.onSuccess($0) }
        return process
    }
}

public extension CSOperation {
    @discardableResult
    func send(progress: Bool = true, onSuccess: ((Data) -> Void)? = nil) -> CSProcess<Data> {
        navigation.send(operation: self, progress: progress, onSuccess: onSuccess)
    }

    @discardableResult
    func sendWithProgress(onSuccess: ((Data) -> Void)? = nil) -> CSProcess<Data> {
        navigation.sendWithProgress(operation: self, onSuccess: onSuccess)
    }

    @discardableResult
    func sendWithFailedDialog() -> CSProcess<Data> { navigation.sendWithFailedDialog(operation: self) }
}