//
// Created by Rene on 2018-11-22.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

import UIKit

public extension Collection {
    public var hasItems: Bool { return !isEmpty }
}

public extension Array where Element: Any {
    public mutating func put(_ newElement: Element) {
        append(newElement)
    }

    public mutating func add(_ newElement: Element) -> Element {
        append(newElement)
        return newElement
    }
}

public extension Dictionary {
    public mutating func add(_ other: Dictionary) {
        other.forEach { (k, v) in self[k] = v }
    }
}


