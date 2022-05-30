open class CSServerMapData: CSJsonObject, CSHttpResponseDataProtocol {
    static let PARSING_FAILED = "Parsing data as json failed"

    open var message: String?, code: Int?

    open func onHttpResponse(code: Int, message: String, content: String?) {
        self.code = code; self.message = message;
        if let data = content?.parseJsonObject() {
            load(data: data as! [String: CSAnyProtocol?])
        }
        else {
            self.message = CSServerMapData.PARSING_FAILED
        }
    }

    open var success: Bool { isHttpSuccess }
}
