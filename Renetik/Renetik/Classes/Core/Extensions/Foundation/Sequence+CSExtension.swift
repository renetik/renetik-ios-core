//
// Created by Rene Dohan on 12/16/19.
//

import Foundation

public extension Sequence {
    @discardableResult
    func each(_ function: (Element) -> Void) -> Self {
        forEach { element in function(element) }
        return self
    }
}

extension Sequence where Element: AnyObject {
//    @inlinable public func contains(where predicate: (Self.Element) throws -> Bool) rethrows -> Bool
}