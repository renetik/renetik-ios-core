//
// Created by Rene Dohan on 12/4/19.
// Copyright (c) 2019 Renetik. All rights reserved.
//

import Renetik

public protocol CSHttpResponseDataProtocol {
    var success: Bool { get }
    var message: String? { get }
    var code: Int? { get }
    func onHttpResponse(code: Int, message: String, content: String?)
}

public extension CSHttpResponseDataProtocol {
    var isHttpUnauthorized: Bool { code == 401 }
    var isHttpNoContent: Bool { code == 204 }
    var isHttpSuccess: Bool { code?.in(range: 200...299) ?? false }
}

open class CSHttpResponseData: CSHttpResponseDataProtocol {
    open var code: Int?, message: String?, content: String?

    open func onHttpResponse(code: Int, message: String, content: String? = nil) {
        self.code = code; self.message = message; self.content = content
    }

    open var success: Bool { isHttpSuccess }
}