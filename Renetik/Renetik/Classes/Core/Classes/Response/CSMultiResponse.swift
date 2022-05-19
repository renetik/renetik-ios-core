//
// Created by Rene Dohan on 3/9/20.
//

import Foundation

public class CSMultiResponse: CSResponse<NSMutableArray> {

    var response: CSResponseProtocol!

    public override init() { super.init(); self.data = NSMutableArray() }

    @discardableResult
    public func add<Data: AnyObject, Response: CSResponse<Data>>(_ response: Response) -> Response {
        data.add(response.data)
        self.response = failIfFail(response)
        return response
    }

    @discardableResult
    public func add<Data: AnyObject, Response: CSResponse<Data>>(last request: Response) -> Response {
        add(request).onSuccess { data in self.success() }
    }

    public override func cancel() {
        super.cancel()
        response.cancel()
    }
}