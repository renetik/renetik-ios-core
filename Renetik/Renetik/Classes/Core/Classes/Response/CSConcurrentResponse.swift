//
//  Renetik Software
//
//  Created by Rene Dohan on 3/14/19.
//

import RenetikObjc

public class CSConcurrentResponse: CSResponse<NSMutableArray> {
    var failedResponses: [CSResponse<AnyObject>] = []
    var responses: [CSResponse<AnyObject>] = []

    public override init() {
        super.init()
        self.data = NSMutableArray()
    }

    public init<T: AnyObject>(_ response: CSResponse<T>) {
        super.init()
        add(response)
    }

    @discardableResult
    public func add<T: AnyObject>(_ response: CSResponse<T>) -> CSResponse<T> {
        data.add(response.data)
        (response as! CSResponse<AnyObject>).also { response in
            responses.add(response)
            response.onFailed { _ in self.onResponseFailed(response) }
                    .onSuccess { _ in self.onResponseSuccess(response) }
        }
        return response
    }

    public func onAddDone() {
        Renetik.later { if self.responses.isEmpty { self.onResponsesDone() } }
    }

    func onResponseSuccess(_ response: CSResponse<AnyObject>) {
        responses.remove(response)
        if responses.isEmpty { onResponsesDone() }
    }

    func onResponseFailed(_ failedResponse: CSResponse<AnyObject>) {
        responses.remove(failedResponses.add(failedResponse))
        if responses.isEmpty { onResponsesDone() }
    }

    override open func cancel() {
        for response in responses { response.cancel() }
        super.cancel()
    }

    func onResponsesDone() {
        if failedResponses.hasItems { failed(failedResponses.first!) }
        else { success(data) }
    }


}