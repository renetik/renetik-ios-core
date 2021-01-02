//
// Created by Rene Dohan on 12/4/19.
// Copyright (c) 2019 Bowbook. All rights reserved.
//

import Renetik
import RenetikObjc

public protocol CSOperationProtocol {
    func onFailed(_ function: @escaping (CSProcessProtocol) -> Void) -> Self
}

public class CSOperation<Data>: CSAnyProtocol, CSOperationProtocol {

    public var data: Data?
    private let executeProcessFunction: (CSOperation<Data>) -> CSProcess<Data>

    public init(function: @escaping (CSOperation<Data>) -> CSProcess<Data>) {
        executeProcessFunction = function
    }

    open func executeProcess() -> CSProcess<Data> { executeProcessFunction(self) }

    private let eventSuccess: CSEvent<Data> = event()

    @discardableResult
    public func onSuccess(_ function: @escaping (Data) -> Void) -> Self {
        invoke { eventSuccess.listen { function($0) } }
    }

    private let eventFailed: CSEvent<CSProcessProtocol> = event()

    @discardableResult
    public func onFailed(_ function: @escaping (CSProcessProtocol) -> Void) -> Self {
        invoke { eventFailed.listen { function($0) } }
    }

    @discardableResult
    public func onFailed(_ function: @escaping Func) -> Self { onFailed { _ in function() } }

    private let eventCancel: CSEvent<CSProcess<Data>> = event()

    @discardableResult
    public func onCancel(_ function: @escaping (CSProcess<Data>) -> Void) -> Self {
        invoke { eventCancel.listen { function($0) } }
    }

    public let eventDone: CSEvent<Data?> = event()

    @discardableResult
    public func onDone(_ function: @escaping ArgFunc<Data?>) -> Self {
        invoke { eventDone.listen { function($0) } }
    }

    @discardableResult
    public func onDone(_ function: @escaping Func) -> Self { onDone { _ in function() } }

    private var process: CSProcess<Data>? = nil
    public var isCached = true
    public var isRefresh = false
    public var expireMinutes: Int? = 1

    public var isLoading: Bool { process?.isDone == false }

    @discardableResult
    public func refresh(_ value: Bool = true) -> Self { invoke { isRefresh = true } }

    @discardableResult
    public func expire(minutes: Int?) -> Self { invoke { expireMinutes = minutes } }

    public func send(listenOnFailed: Bool = true) -> CSProcess<Data> {
        executeProcess().also { process in
            self.process = process
            process.onSuccess { data in
                self.data = data
                self.eventSuccess.fire(process.data!)
                self.eventDone.fire(process.data)
            }
            if listenOnFailed { process.onFailed(failed) }
        }
    }

    public func cancel() {
        process.notNil { process in
            if process.isFailed {
                eventFailed.fire(process)
                eventDone.fire(process.data)
            } else {
                process.cancel()
                eventDone.fire(process.data)
            }
        }
    }

    public func failed(process: CSProcessProtocol) {
        eventFailed.fire(process)
        eventDone.fire(self.process?.data)
        self.process = nil
    }

}

extension CSOperation {
    public func sendSilently() -> Self { send(listenOnFailed: true); return self }
}
