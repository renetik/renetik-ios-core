//
// Created by Rene Dohan on 1/24/20.
//

import Foundation

public extension Array where Element: Any {

    var isSet: Bool { !isEmpty }

    var isNotEmpty: Bool { !isEmpty }

    var second: Element? { at(1) }

    var third: Element? { at(2) }

    func at(_ index: Int) -> Element? {
        if index >= 0 && index < count { return self[index] }
        return nil
    }

    @discardableResult
    mutating func add(_ item: Element) -> Element {
        append(item)
        return item
    }

    @discardableResult
    mutating func add(array: Array<Element>) -> Array {
        append(contentsOf: array)
        return self
    }

    @discardableResult
    mutating func reload(_ array: Array<Element>) -> Array {
        removeAll()
        add(array: array)
        return self
    }
}

public extension Array where Element: Equatable {
    @discardableResult
    mutating func remove(_ item: Element) -> Element? {
        if let index = firstIndex(where: { item == $0 }) {
            return remove(at: index)
        }
        return nil
    }

    @discardableResult
    mutating func remove(all item: Element) -> Self {
        removeAll(where: { item == $0 })
        return self
    }

    @discardableResult
    mutating func remove(_ items: [Element]) -> Self {
        items.each { item in remove(all: item) }
        return self
    }

    func previous(of item: Element) -> Element? { index(of: item)?.get { index -> Element? in at(index - 1) } }

    func previousIndex(of item: Element) -> Int? { index(of: item)?.get { index -> Int in index - 1 } }

    func next(of item: Element) -> Element? { index(of: item)?.get { index -> Element? in at(index + 1) } }

    func index(of item: Element) -> Int? { firstIndex(of: item) }

    @discardableResult
    mutating func clear() -> Self {
        removeAll()
        return self
    }

    @inlinable public mutating func removeIf(condition: (Self.Element) throws -> Bool) rethrows {
        try removeAll(where: condition)
    }
}

public extension Array where Element: CustomStringConvertible {
    func filter(bySearch searchText: String) -> [Element] {
        if searchText.isSet {
            var filtered = [Element]()
            for item in self {
                if item.description.contains(searchText, ignoreCase: true) {
                    filtered.add(item)
                }
            }
            return filtered
        }
        return self
    }
}

public extension Array where Element: CSSearchNameProtocol, Element: CustomStringConvertible {
    func filter(bySearch searchText: String) -> [Element] {
        if searchText.isSet {
            var filtered = [Element]()
            for item in self {
                if (item.searchName ?? item.description)
                       .contains(searchText, ignoreCase: true) {
                    filtered.add(item)
                }
            }
            return filtered
        }
        return self
    }
}

extension NSArray {
    var isEmpty: Bool { count == 0 }
}

extension NSMutableArray {
    func reload(_ array: [Any]) -> Self {
        removeAllObjects()
        addObjects(from: array)
        return self
    }
}