//
// Created by Rene on 2018-11-22.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

import Foundation

public extension Collection {
    public var hasItems: Bool { !isEmpty }
    public var size: Int { count }
}

public extension Array where Element: Any {
    public func at(_ index: Int) -> Element? {
        if index >= 0 && index < count { return self[index] }
        return nil
    }

    public var second: Element? {
        return at(1)
    }

    public var third: Element? {
        return at(2)
    }

    @discardableResult
    public mutating func add(_ item: Element) -> Element {
        append(item)
        return item
    }

    @discardableResult
    public mutating func add(array: Array<Element>) -> Array {
        append(contentsOf: array)
        return self
    }

    @discardableResult
    public mutating func reload(_ array: Array<Element>) -> Array {
        removeAll()
        add(array: array)
        return self
    }
}

public extension Array where Element: Equatable {
    @discardableResult
    public mutating func remove(_ item: Element) -> Element? {
        if let index = firstIndex(where: { item == $0 }) {
            return remove(at: index)
        }
        return nil
    }

    @discardableResult
    public mutating func removeAll(_ item: Element) -> Self {
        removeAll(where: { item == $0 })
        return self
    }

    @discardableResult
    public mutating func clear() -> Self {
        removeAll()
        return self
    }
}

public extension Array where Element: Equatable & CustomStringConvertible {

    func filter(bySearch searchText: String?) -> [Element] {
        if searchText?.isSet == true {
            var filtered = [Element]()
            for item in self {
                if item.description.containsNoCase(searchText) {
                    filtered.add(item)
                }
            }
            return filtered
        }
        return self
    }
}

public extension Dictionary {
    @discardableResult
    public mutating func add(_ other: Dictionary) -> Dictionary {
        other.forEach { k, v in self[k] = v }
        return self
    }

    public var asJson: String? {
        if let theJSONData = try? JSONSerialization.data(
                withJSONObject: self, options: [.prettyPrinted]) {
            return String(data: theJSONData, encoding: .ascii)
        }
        return nil
    }
}
