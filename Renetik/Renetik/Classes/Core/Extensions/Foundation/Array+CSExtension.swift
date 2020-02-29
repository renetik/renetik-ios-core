//
// Created by Rene Dohan on 1/24/20.
//

import Foundation

public extension Array where Element: Any {
    public func at(_ index: Int) -> Element? {
        if index >= 0 && index < count { return self[index] }
        return nil
    }

    @discardableResult
    public func each(_ function: (Element) -> Void) -> Self {
        forEach { element in function(element) }
        return self
    }

    public var second: Element? { at(1) }

    public var third: Element? { at(2) }

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
    public mutating func remove(all item: Element) -> Self {
        removeAll(where: { item == $0 })
        return self
    }

    public func previous(of item: Element) -> Element? { index(of: item)?.get { index -> Element? in at(index - 1) } }

    public func previousIndex(of item: Element) -> Int? { index(of: item)?.get { index -> Int in index - 1 } }

    public func next(of item: Element) -> Element? { index(of: item)?.get { index -> Element? in at(index + 1) } }

    public func index(of item: Element) -> Int? { firstIndex(of: item) }

    @discardableResult
    public mutating func clear() -> Self {
        removeAll()
        return self
    }
}

public extension Array where Element: Equatable & CustomStringConvertible {

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