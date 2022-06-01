//
//  String+CSExtension.swift
//  Renetik
//
//  Created by Rene Dohan on 2/14/19.
//

import Foundation

public extension String {

    static let newLine = "\n"

    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in
            letters.randomElement()!
        })
    }

    var isSet: Bool { !isEmpty }

    var isNotEmpty: Bool { !isEmpty }

    var length: Int { count }

    var asNSString: NSString { self as NSString }

    var boolValue: Bool { Bool(self)! }

    var doubleValue: Double { Double(self)! }

    var intValue: Int { Int(self)! }

    var floatValue: Float { Float(self)! }

    func trim() -> String { asNSString.trim() }

    func removeAccents() -> String { folding(options: .diacriticInsensitive, locale: .current) }

    func substring(from index: Int) -> String {
        asNSString.substring(from: index, to: length) as String
    }

    func substring(to index: Int) -> String {
        asNSString.substring(from: 0, to: index) as String
    }

    func substring(from: Int, to: Int) -> String {
        asNSString.substring(from: from, to: to) as String
    }

    func substring(_ range: ClosedRange<Int>) -> String {
        substring(from: range.first!, to: range.last!)
    }

    var deleteLastPathComponent: String { asNSString.deletingLastPathComponent }

    @inlinable func stringIndex(at: String.IndexDistance) -> String.Index {
        self.index(startIndex, offsetBy: at)
    }

    func index(of string: String, from: Int) -> Int? {
        let index = asNSString.index(of: string, from: from)
        return index >= 0 ? index : nil
    }

    func index(of string: String) -> Int? { index(of: string, from: 0) }

    func contains(_ string: String, ignoreCase: Bool = false) -> Bool {
        ignoreCase ? asNSString.containsNoCase(string) : asNSString.contains(string)
    }

    func ends(with value: String) -> Bool { hasSuffix(value) }

    func starts(with value: String) -> Bool { hasPrefix(value) }

    func remove(_ string: String) -> String { remove(all: string) }

    func remove(all string: String) -> String { replace(all: string, with: "") }

    func replace(all string: String, with replace: String) -> String {
        replacingOccurrences(of: string, with: replace)
    }

    public func replace(range: NSRange, with string: String) -> String {
        asNSString.replacingCharacters(in: range, with: string)
    }

    func attributed(_ dictionary: [NSAttributedString.Key: Any] = [:]) -> NSAttributedString {
        NSAttributedString(string: self, attributes: dictionary)
    }

    func split(by separator: String) -> [String] { components(separatedBy: separator) }

    func indices(of occurrence: String) -> [Int] {
        var indices = [Int]()
        var position = startIndex
        while let range = range(of: occurrence, range: position..<endIndex) {
            let i = distance(from: startIndex,
                to: range.lowerBound)
            indices.append(i)
            let offset = occurrence.distance(from: occurrence.startIndex,
                to: occurrence.endIndex) - 1
            guard let after = index(range.lowerBound,
                offsetBy: offset,
                limitedBy: endIndex)
            else {
                break
            }
            position = index(after: after)
        }
        return indices
    }

    func ranges(of searchString: String) -> [Range<String.Index>] {
        let _indices = indices(of: searchString)
        let count = searchString.count
        return _indices.map({ index(startIndex, offsetBy: $0)..<index(startIndex, offsetBy: $0 + count) })
    }
}

public extension Optional where Wrapped == String {
    public var isNilOrEmpty: Bool {
        if self == nil { return true }
        return self!.isEmpty
    }

    public var isEmpty: Bool { isNilOrEmpty }

    public var isNotEmpty: Bool {
        if self == nil { return false }
        return self!.isNotEmpty
    }

    public func nilOrEmpty(_ function: Func) -> Self {
        if isNilOrEmpty { function() }
        return self
    }

    public var isSet: Bool {
        if self == nil { return false }
        return self!.isSet
    }

    public func contains(_ string: String, ignoreCase: Bool = false) -> Bool {
        if self == nil { return false }
        return self!.contains(string, ignoreCase: ignoreCase)
    }
}