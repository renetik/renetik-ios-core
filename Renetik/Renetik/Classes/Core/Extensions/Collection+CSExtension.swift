//
// Created by Rene on 2018-11-22.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

import UIKit

public extension Collection {
    public var hasItems: Bool { return !isEmpty }
}

public extension Array where Element: Any {
    public func at(_ index: Int) -> Element? {
        if index >= 0 && index < count {
            return self[index]
        }
        return nil
    }

    @discardableResult
    public mutating func add(_ item: Element) -> Element {
        append(item)
        return item
    }
	
	@discardableResult
	public mutating func add(_ array: Array<Element>) -> Array {
		append(contentsOf: array)
		return self
	}

    @discardableResult
    public func remove(_ anObject: Any) -> Array {
        remove(anObject)
        return self
    }
}

public extension Array where Element: NSObject {
    public func filter(bySearch searchText: String?) -> Array {
        if searchText?.set != nil {
            var filtered = Array<Element>()
            for item: Element in self {
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
}
