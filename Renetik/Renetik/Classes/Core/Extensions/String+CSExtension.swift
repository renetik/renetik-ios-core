//
//  String+CSExtension.swift
//  Renetik
//
//  Created by Rene Dohan on 2/14/19.
//

import Foundation

public extension String {
    public func htmlToText(_ encoding: String.Encoding) -> String? {
        if let data = data(using: encoding) {
            return (try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil))?.string
        }
        return nil
    }

    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }

    public var isSet: Bool { return !isEmpty }

    public var set: Bool { return isSet }

    public var trim: String { return asNSString.trim() }

    public var asNSString: NSString { return (self as NSString) }

    public var boolValue: Bool {
        return asNSString.boolValue
    }
}

public extension Optional where Wrapped == String {
    public var isNilOrEmpty: Bool {
        if self == nil { return true }
        return self!.isEmpty
    }

    public var isSet: Bool {
        if self == nil { return false }
        return !self!.isEmpty
    }

    public func contains(_ string: String) -> Bool {
        if self == nil { return false }
        return self!.contains(string)
    }
}
