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

    public var isSet: Bool { return !isEmpty }
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
