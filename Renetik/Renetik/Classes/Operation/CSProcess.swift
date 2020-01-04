//
// Created by Rene Dohan on 12/4/19.
// Copyright (c) 2019 Bowbook. All rights reserved.
//

import Foundation

public class CSProcess<Data>: CSAny, CSProcessProtocol {
    private let eventSuccess: CSEvent<CSProcess<Data>> = event()

    public func onSuccess(_ function: @escaping (Data) -> Void) -> Self {
        eventSuccess.add { function($0.argument.data!) }
        return self
    }

    private let eventFailed: CSEvent<CSProcessProtocol> = event()

    @discardableResult
    public func onFailed(_ function: @escaping (CSProcessProtocol) -> Void) -> Self {
        invoke { eventFailed.add { function($0.argument) } }
    }

    private let eventCancel: CSEvent<CSProcess<Data>> = event()

    @discardableResult
    public func onCancel(_ function: @escaping (CSProcess<Data>) -> Void) -> Self {
        invoke { eventCancel.add { function($0.argument) } }
    }

    private let eventDone: CSEvent<Data?> = event()

    @discardableResult
    public func onDone(_ function: @escaping (Data?) -> Void) -> Self {
        invoke { eventDone.add { function($0.argument) } }
    }

    private let onProgress: CSEvent<CSProcess<Data>> = event()
    var progress: UInt64 = 0 { didSet { onProgress.fire(self) } }
    var isSuccess = false
    var isFailed = false
    var isDone = false
    var isCanceled = false
    var url: String? = nil
//    public var title: String? = nil
    var data: Data? = nil
    public var operationCancelledMessage = "Operation was canceled."
    public var errorMessage: String? = nil
    public var error: Error? = nil
    var failedProcess: CSProcessProtocol? = nil

    init(_ url: String, _ data: Data) {
        self.url = url
        self.data = data
    }

    init(_ data: Data?) { self.data = data }

    func success() {
        if isCanceled { return }
        onSuccessImpl()
        onDoneImpl()
    }

    func success(_ data: Data) {
        if isCanceled { return }
        self.data = data
        onSuccessImpl()
        onDoneImpl()
    }

    private func onSuccessImpl() {
        logInfo("Response onSuccessImpl \(self) \(url.asString)")
        if isFailed { logError("already failed") }
        if isSuccess { logError("already success") }
        if isDone { logError("already done") }
        isSuccess = true
        eventSuccess.fire(self)
    }

    func failed(_ process: CSProcessProtocol) {
        if isCanceled { return }
        onFailedImpl(process)
        onDoneImpl()
    }

    func failed(_ message: String) -> CSProcess<Data> {
        if isCanceled { return self }
        errorMessage = message
        failed(self)
        return self
    }

    func failed(_ error: Error?, message: String? = nil) {
        if isCanceled { return }
        self.error = error
        errorMessage = message ?? error?.localizedDescription
        failed(self)
    }

    private func onFailedImpl(_ process: CSProcessProtocol) {
        if isFailed { logError("already failed") }
        if isDone { logError("already done") }
        failedProcess = process
        isFailed = true
        errorMessage = process.errorMessage
        error = process.error
        logError("\(errorMessage.asString), \(error.asString.asString)")
        eventFailed.fire(process)
    }

    open func cancel() {
        logDebug("Response cancel \(self) isCanceled \(isCanceled) isDone \(isDone) " +
                "isSuccess \(isSuccess) isFailed \(isFailed)")
        if (isCanceled || isDone || isSuccess || isFailed) { return }
        isCanceled = true
        self.errorMessage = operationCancelledMessage
        eventCancel.fire(self)
        onDoneImpl()
    }

    private func onDoneImpl() {
        logDebug("Response onDone \(self)")
        if isDone {
            logError("already done")
            return
        }
        isDone = true
        eventDone.fire(data)
    }
}
