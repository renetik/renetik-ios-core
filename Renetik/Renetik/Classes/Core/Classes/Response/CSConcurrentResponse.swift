//
//  Renetik Software
//
//  Created by Rene Dohan on 3/14/19.
//

import RenetikObjc

public class CSConcurrentResponse: CSResponse<NSMutableArray> {
    var failedResponses: NSMutableArray = NSMutableArray()
    var responses: NSMutableArray = NSMutableArray()

    public override init() { super.init(); self.data = NSMutableArray() }

    public init<T: AnyObject>(_ response: CSResponse<T>) {
        super.init()
        add(response)
    }

    @discardableResult
    public func add<T: AnyObject>(_ response: CSResponse<T>) -> CSResponse<T> {
        data!.add(response.data!)
        responses.add(response)
        response.onFailed { _ in self.onResponseFailed(response) }
                .onSuccess { _ in self.onResponseSuccess(response) }
        return response
    }

    public func onAddDone() { later { if self.responses.empty { self.onResponsesDone() } } }

    func onResponseSuccess<T: AnyObject>(_ response: CSResponse<T>) {
        responses.remove(response)
        if responses.empty { onResponsesDone() }
    }

    func onResponseFailed<T: AnyObject>(_ failedResponse: CSResponse<T>) {
        responses.remove(failedResponses.add(failedResponse))
        if responses.empty { onResponsesDone() }
    }

    override open func cancel() {
        for response in responses { (response as! CSResponseProtocol).cancel() }
        super.cancel()
    }

    func onResponsesDone() {
        if failedResponses.hasItems {
            failed(failedResponses.first as! CSResponseProtocol)
        } else {
            success(data!)
        }
    }


}