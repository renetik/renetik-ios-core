//
// Created by Rene Dohan on 12/26/19.
//

import Foundation

public protocol CSValueProtocol {
    associatedtype T
    var value: T { get }
}

public extension CustomStringConvertible where T == String, Self: CSValueProtocol {
    public var description: String { value }
}