//
// Created by Rene Dohan on 12/30/19.
// Copyright (c) 2019 Renetik. All rights reserved.
//

import Foundation
import RenetikCore

public protocol CSOperationController {
    @discardableResult
    func send<Data>(_ operation: CSOperation<Data>, _ title: String, _ progress: Bool,
                    _ canCancel: Bool, _ failedDialog: Bool, _ onInternetFailed: (() -> Void)?,
                    _ onSuccess: ((Data) -> Void)?) -> CSOperation<Data>
}

public extension CSOperationController {

    @discardableResult
    func send<Data>(operation: CSOperation<Data>, title: String, progress: Bool = true,
                    canCancel: Bool = true, failedDialog: Bool = true, onInternetFailed: (() -> Void)? = nil,
                    onSuccess: ((Data) -> Void)? = nil) -> CSOperation<Data> {
        send(operation, title, progress, canCancel, failedDialog, onInternetFailed, onSuccess)
    }
}