//
// Created by Rene Dohan on 3/7/20.
//

import Foundation

public class CSSequenceResponse<Data: CSAnyProtocol>: CSResponse<Data> {

    var response: CSResponseProtocol!

    public override init() { super.init() }

    @discardableResult
    public func add<Data: CSAnyProtocol, Response: CSResponse<Data>>(_ response: Response) -> Response {
        self.response = failIfFail(response)
        return response
    }

    public override func cancel() {
        super.cancel()
        response.cancel()
    }

    @discardableResult
    public func add<Response: CSResponse<Data>>(last request: Response) -> Response {
        add(request).onSuccess { data in self.success(data) }
    }
}