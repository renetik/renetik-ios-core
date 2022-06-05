//
// Created by Rene Dohan on 1/11/20.
//

import Foundation

public protocol CSNameProtocol {
    var name: String { get }
}

public extension CustomStringConvertible where Self: CSNameProtocol {
    var description: String { name }
}

public protocol CSSearchNameProtocol {
    var searchName: String? { get }
}