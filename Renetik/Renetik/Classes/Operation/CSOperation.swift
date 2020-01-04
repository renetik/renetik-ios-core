//
// Created by Rene Dohan on 12/4/19.
// Copyright (c) 2019 Bowbook. All rights reserved.
//

import Renetik
import RenetikObjc

public class CSOperation<Data: CSAny>: CSAny {

    public let title: String
    private let executeProcessFunction: (CSOperation<Data>) -> CSProcess<Data>

    public init(title: String, function: @escaping (CSOperation<Data>) -> CSProcess<Data>) {
        executeProcessFunction = function
        self.title = title
    }

    open func executeProcess() -> CSProcess<Data> { executeProcessFunction(self) }

    private let eventSuccess: CSEvent<Data> = event()

    @discardableResult
    public func onSuccess(_ function: @escaping (Data) -> Void) -> Self {
        invoke { eventSuccess.add { function($0.argument) } }
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

    private var process: CSProcess<Data>? = nil

    public var isRefresh = false
    public var isCached = true
    public var expireMinutes: Int? = 1
    public var isJustUseCache = false

    public func refresh() -> Self { invoke { isRefresh = true } }

    public func send() -> CSProcess<Data> {
        executeProcess().also { process in
            self.process = process
            process.onSuccess { data in
                self.eventSuccess.fire(process.data!)
                self.eventDone.fire(process.data)
            }
        }
    }

    public func cancel() {
        process.notNil { it in
            if it.isFailed {
                self.eventFailed.fire(it)
                self.eventDone.fire(it.data)
            } else {
                it.cancel()
                self.eventDone.fire(it.data)
            }
        }
    }
}
