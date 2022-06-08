//
// Created by Rene Dohan on 12/4/19.
// Copyright (c) 2019 Renetik. All rights reserved.
//

import RenetikCore
import RenetikObjc

public protocol CSOperationProtocol {
    func onSuccess(_ function: @escaping Func) -> Self
    func onFailed(_ function: @escaping Func) -> Self
    func onDone(_ function: @escaping Func) -> Self
    func cancel()
}

public class CSOperation<Data>: CSAnyProtocol, CSOperationProtocol {

    public var isCanceled = false
    public weak var process: CSProcess<Data>? = nil
    public var data: Data? { process?.data }
    public var failedProcess: CSProcessProtocol? { process?.failedProcess }

    private let executeProcessFunction: (CSOperation<Data>) -> CSProcess<Data>

    public init(function: @escaping (CSOperation<Data>) -> CSProcess<Data>) {
        executeProcessFunction = function
    }

    public convenience init(function: @escaping () -> CSProcess<Data>) {
        self.init { _ in function() }
    }

    open func executeProcess() -> CSProcess<Data> { executeProcessFunction(self) }

    private let eventSuccess: CSEvent<Data> = event()

    @discardableResult
    public func onSuccess(_ function: @escaping (Data) -> Void) -> Self {
        invoke { eventSuccess.listen { function($0) } }
    }

    @discardableResult
    public func onSuccess(_ function: @escaping Func) -> Self { onSuccess { _ in function() } }

    private let eventFailed: CSEvent<CSProcessProtocol> = event()

    @discardableResult
    public func onFailed(_ function: @escaping Func) -> Self { onFailed { _ in function() } }

    @discardableResult
    public func onFailed(_ function: @escaping ArgFunc<CSOperation<Data>>) -> Self {
        eventFailed.listen { [unowned self] _ in function(self) }; return self
    }

    private let eventCancel: CSEvent<CSProcess<Data>> = event()

    @discardableResult
    public func onCancel(_ function: @escaping (CSProcess<Data>) -> Void) -> Self {
        invoke { eventCancel.listen { function($0) } }
    }

    public let eventDone: CSEvent<Data?> = event()

    @discardableResult
    public func onDone(_ function: @escaping ArgFunc<CSOperation<Data>>) -> Self {
        invoke { eventDone.listen { [unowned self] _ in function(self) } }
    }

    @discardableResult
    public func onDone(_ function: @escaping Func) -> Self { onDone { _ in function() } }

    public var isCached = true
    public var isRefresh = false
    public var expireMinutes: Int? = 1

    public var isLoading: Bool { process?.isDone == false }

    @discardableResult
    public func refresh(_ value: Bool = true) -> Self { invoke { isRefresh = true } }

    @discardableResult
    public func expire(minutes: Int?) -> Self { invoke { expireMinutes = minutes } }

    @discardableResult
    public func send(listenOnFailed: Bool = true, onSuccess: ArgFunc<Data>? = nil) -> Self {
        process = executeProcess().also { process in
            process.onSuccess { [unowned self] in
                onSuccess?($0)
                eventSuccess.fire($0)
                eventDone.fire($0)
            }
            if listenOnFailed { process.onFailed(failed) }
        }
        return self
    }

    public func cancel() {
        isCanceled = true
        process.notNil { process in
            process.cancel()
            eventDone.fire(process.data)
        }
    }

    public func failed(process: CSProcessProtocol) {
        eventFailed.fire(process)
        eventDone.fire(self.process?.data)
        self.process = nil
    }

}

extension CSOperation {
    public func send(listenOnFailed: Bool = true, onSuccess: @escaping Func) -> Self {
        send(listenOnFailed: listenOnFailed) { _ in onSuccess() }
    }
}
