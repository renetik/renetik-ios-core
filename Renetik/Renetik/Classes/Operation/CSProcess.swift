//
// Created by Rene Dohan on 12/4/19.
// Copyright (c) 2019 Renetik. All rights reserved.
//

import Foundation

public class CSProcess<Data>: CSAnyProtocol, CSProcessProtocol {
    private let eventSuccess: CSEvent<CSProcess<Data>> = event()

    @discardableResult
    public func onSuccess(_ function: @escaping (Data) -> Void) -> Self {
        eventSuccess.listen { function($0.data!) }
        return self
    }

    @discardableResult
    public func onSuccess(_ function: @escaping Func) -> Self { onSuccess { _ in function() } }

    private let eventFailed: CSEvent<CSProcessProtocol> = event()

    @discardableResult
    public func onFailed(_ function: @escaping ArgFunc<CSProcess<Data>>) -> Self {
        onFailed { function(self) }
    }

    @discardableResult
    public func onFailed(_ function: @escaping Func) -> Self {
        eventFailed.listen { _ in function() }; return self
    }

    private let eventCancel: CSEvent<CSProcess<Data>> = event()

    @discardableResult
    public func onCancel(_ function: @escaping (CSProcess<Data>) -> Void) -> Self {
        eventCancel.listen { function($0) }; return self
    }

    public let eventDone: CSEvent<Data?> = event()

    @discardableResult
    public func onDone(_ function: @escaping ArgFunc<Data?>) -> Self {
        eventDone.listen { function($0) }; return self
    }

    @discardableResult
    public func onDone(_ function: @escaping  Func) -> Self { onDone { _ in function() } }

    private let onProgress: CSEvent<CSProcess<Data>> = event()
    var progress: Double = 0 { didSet { onProgress.fire(self) } }
    var isSuccess = false
    var isFailed = false
    var isDone = false
    var isCanceled = false
    var url: String? = nil
    public var data: Data? = nil
    public var message: String? = nil
    public var error: Error? = nil
    public var failedProcess: CSProcessProtocol? = nil

    public init(url: String? = nil, data: Data? = nil) {
        self.url = url
        self.data = data
    }

    @discardableResult
    public func success() {
        if isCanceled { return }
        onSuccessImpl()
        onDoneImpl()
    }

    @discardableResult
    public func success(_ data: Data) {
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

    @discardableResult
    public func failed(_ process: CSProcessProtocol) {
        if isCanceled { return }
        onFailedImpl(process)
        onDoneImpl()
    }

    @discardableResult
    public func failed(_ message: String) -> CSProcess<Data> {
        if isCanceled { return self }
        self.message = message
        failed(self)
        return self
    }

    @discardableResult
    public func failed(_ error: Error?, message: String? = nil) {
        if isCanceled { return }
        self.error = error
        self.message = message ?? error?.localizedDescription ?? .operationFailed
        failed(self)
    }

    private func onFailedImpl(_ process: CSProcessProtocol) {
        if isFailed { logError("already failed") }
        if isDone { logError("already done") }
        failedProcess = process
        isFailed = true
        message = process.message
        error = process.error
        logError("message:\(message.asString), error:\(error.asString)")
        eventFailed.fire(process)
    }

    open func cancel() {
        logInfo("Response cancel \(self) isCanceled \(isCanceled) isDone \(isDone) " +
                "isSuccess \(isSuccess) isFailed \(isFailed)")
        if (isCanceled || isDone || isSuccess || isFailed) { return }
        isCanceled = true
        message = .operationCancelled
        eventCancel.fire(self)
        onDoneImpl()
    }

    private func onDoneImpl() {
        logInfo()
        if isDone {
            logError("isDone")
            return
        }
        isDone = true
        eventDone.fire(data)
    }
}

extension CSProcess {
    @discardableResult
    public func failIfFail<Data: AnyObject>(_ process: CSProcess<Data>) -> CSProcess<Data> {
        process.onFailed { self.failed($0) }
    }

}

public class CSMultiProcess: CSProcess<NSMutableArray> {

    var process: CSProcessProtocol!

    public init() { super.init(); data = NSMutableArray() }

    @discardableResult
    public func add<Data: AnyObject, Process: CSProcess<Data>>(_ process: Process) -> Process {
        data!.add(process.data)
        self.process = failIfFail(process)
        return process
    }

    @discardableResult
    public func add<Data: AnyObject, Process: CSProcess<Data>>(last request: Process) -> Process {
        add(request).onSuccess { data in self.success() }
    }

    public override func cancel() {
        super.cancel()
        process.cancel()
    }
}
