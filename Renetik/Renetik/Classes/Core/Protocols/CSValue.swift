//
// Created by Rene Dohan on 12/26/19.
//

import Foundation

public protocol CSValueProtocol {
    associatedtype T
    var value: T { get }
}

public extension CSValueProtocol where T == String, Self: CustomStringConvertible {
    public var description: String {
        logInfo("CSValueProtocol TODO: Does this ever work somewhere ?")
        return value
    }
}