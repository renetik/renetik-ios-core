//
// Created by Rene Dohan on 12/4/19.
// Copyright (c) 2019 Bowbook. All rights reserved.
//

import Renetik

public protocol CSHttpResponseDataProtocol {
    var success: Bool { get }
    var message: String? { get }
    var httpCode: Int? { get }
    func onHttpResponse(code: Int, message: String, content: String?)
}

public extension CSHttpResponseDataProtocol {
    var isUnauthorized: Bool { httpCode == 401 }
    var isNoContent: Bool { httpCode == 204 }
}

open class CSHttpResponseData: CSHttpResponseDataProtocol {
    open var httpCode: Int?, message: String?, content: String?

    open func onHttpResponse(code: Int, message: String, content: String? = nil) {
        httpCode = code; self.message = message; self.content = content
    }

    open var success: Bool { httpCode?.in(range: 200...299) ?? false }
}

open class CSServerMapData: CSJsonObject, CSHttpResponseDataProtocol {
    static let PARSING_FAILED = "Parsing data as json failed"
    open var message: String?
    open var httpCode: Int?

    open func onHttpResponse(code: Int, message: String, content: String?) {
        httpCode = code; self.message = message;
        content?.parseJsonObject().notNil {
            load(data: $0)
        }.elseDo { self.message = CSServerMapData.PARSING_FAILED }
    }

    open var success: Bool { httpCode?.in(range: 200...299) ?? false }
}