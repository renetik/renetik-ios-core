//
// Created by Rene Dohan on 1/11/20.
//

import Foundation

public protocol CSNameProtocol {
    var name: String { get }
}

extension CustomStringConvertible where Self: CSNameProtocol {
    var description: String { name }
}