//
//  String+CSExtension.swift
//  Renetik
//
//  Created by Rene Dohan on 2/14/19.
//

import Foundation
import RenetikObjc

public extension String {

    public func htmlToText(_ encoding: String.Encoding) -> String? {
        if let data = data(using: encoding) {
            return (try? NSAttributedString(data: data,
                    options: [.documentType: NSAttributedString.DocumentType.html],
                    documentAttributes: nil))?.string
        }
        return nil
    }

    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in
            letters.randomElement()!
        })
    }

    public var isSet: Bool {
        !isEmpty
    }

    public var trim: String {
        asNSString.trim()
    }

    public var length: Int {
        count
    }

    public var asNSString: NSString {
        self as NSString
    }

    public var boolValue: Bool {
        asNSString.boolValue
    }

    public var doubleValue: Double {
        asNSString.doubleValue
    }

    public var intValue: Int {
        asNSString.integerValue
    }

    func substring(from: Int) -> String {
        asNSString.substring(from: from, to: length) as String
    }

    func contains(_ string: String?, ignoreCase: Bool = false) -> Bool {
        ignoreCase ? asNSString.containsNoCase(string) : asNSString.contains(string)
    }

    func remove(_ string: String?) -> String {
        asNSString.remove(string.asString)
    }

    func replace(all string: String, with replace: String) -> String {
        asNSString.replace(string, replace)
    }
}

public extension Optional where Wrapped == String {
    public var isNilOrEmpty: Bool {
        if self == nil {
            return true
        }
        return self!.isEmpty
    }

    public func isNilOrEmpty(_ function: () -> Void) -> Self {
        if isNilOrEmpty { function() }
        return self
    }

    public var isSet: Bool {
        if self == nil {
            return false
        }
        return !self!.isEmpty
    }

    public func contains(_ string: String) -> Bool {
        if self == nil {
            return false
        }
        return self!.contains(string)
    }
}
