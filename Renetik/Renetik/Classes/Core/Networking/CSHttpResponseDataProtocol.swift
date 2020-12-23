//
// Created by Rene Dohan on 12/4/19.
// Copyright (c) 2019 Bowbook. All rights reserved.
//

import Renetik

public protocol CSHttpResponseDataProtocol {
    func onHttpResponse(code: Int, message: String, content: String?)
    var success: Bool { get }
    var message: String? { get }
}

open class CSHttpResponseData: CSHttpResponseDataProtocol {
    public var code: Int?, message: String?, content: String?

    public func onHttpResponse(code: Int, message: String, content: String? = nil) {
        self.code = code; self.message = message; self.content = content
    }

    public var success: Bool { code?.get { (200...299).contains($0) } ?? false }
}

let PARSING_FAILED = "Parsing data as json failed"

open class CSServerMapData: CSJsonObject, CSHttpResponseDataProtocol {
    var code: Int? = nil

    open func onHttpResponse(code: Int, message: String, content: String?) {
        content?.parseJsonObject().notNil {
            load(data: $0)
        }.elseDo { put("message", PARSING_FAILED) }
    }

    open var success: Bool { getBoolean("success") ?? false }
    open var message: String? { getString("message") }
}