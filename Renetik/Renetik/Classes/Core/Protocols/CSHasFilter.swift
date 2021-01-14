//
// Created by Rene Dohan on 1/13/21.
//

import Foundation

public protocol CSHasFilterProtocol {
    associatedtype Row
    func filter(data: [Row]) -> [Row]
}

public extension CSHasFilterProtocol {
    func filter(data: [Row]) -> [Row] { data }
}