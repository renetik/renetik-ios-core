//
// Created by Rene Dohan on 12/11/20.
//

import Foundation
import RenetikCore

extension CSProcess where Data: CSHttpResponseDataProtocol {
    public func mockSuccess(code: Int, message: String, content: String) -> Self {
        data!.onHttpResponse(code: 200, message: "", content: "")
        later(seconds: 2 * .Second) { self.success() }
        return self
    }
}