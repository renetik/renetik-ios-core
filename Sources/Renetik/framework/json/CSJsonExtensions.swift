import Foundation

extension String {
    func parseJsonDictionary() -> [String: CSAnyProtocol?]? { parseJson() as? [String: CSAnyProtocol?] }

    func parseJsonArray() -> [CSAnyProtocol?]? { parseJson() as? [CSAnyProtocol?] }

    func parseJson() -> Any? {
        if let data = data(using: .utf8) {
            return try? JSONSerialization.jsonObject(with: data, options: [.mutableContainers, .allowFragments])
        }
        return nil
    }
}

private func jsonString(_ value: Any?, _ formatted: Bool = false) -> String? {
    if value == nil { return nil }
    let options: JSONSerialization.WritingOptions = formatted ? [.prettyPrinted] : []
    if let theJSONData = try? JSONSerialization.data(withJSONObject: value!, options: options) {
        return String(data: theJSONData, encoding: .ascii)
    }
    return nil
}

extension CSAnyProtocol {
    public func toJsonString(formatted: Bool = false) -> String? {
        jsonString(toJsonType(), formatted)
    }

    private func toJsonType() -> Any? {
        if self is Float || self is String || self is Boolean ||
               self is [Any?] || self is [String: Any?] {
            return self
        }
        else if let jsonObject = self as? CSJsonObjectInterface {
            return jsonObject.asDictionary
        }
        else if let jsonArray = self as? CSJsonArrayInterface {
            return jsonArray.asArray
        }
        return asString
    }
}

extension Optional where Wrapped == CSAnyProtocol {
    public func toJsonString(formatted: Bool = false) -> String? {
        self == nil ? jsonString(nil, formatted) : self!.toJsonString(formatted: formatted)
    }
}