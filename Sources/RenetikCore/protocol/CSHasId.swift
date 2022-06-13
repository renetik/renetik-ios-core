//
// Created by Rene Dohan on 1/11/20.
//

import Foundation

public protocol CSHasId {
    var id: String { get }
}

public extension CustomStringConvertible where Self: CSHasId {
    var description: String { id }
}