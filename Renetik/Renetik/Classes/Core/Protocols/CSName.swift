//
// Created by Rene Dohan on 1/11/20.
//

import Foundation

public protocol CSNameProtocol {
    var name: String { get }
}

public extension CSNameProtocol where Self: CustomStringConvertible {
    var description: String { name }
}