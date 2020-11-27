//
// Created by Rene Dohan on 11/22/20.
//

import Foundation

public protocol CSValueProtocol {
    associatedtype T
    var value: T { get }
}

//TODO: Does this ever work somewhere ?
extension CSValueProtocol where T == String, Self: CustomStringConvertible {
    var description: String {
        value
    }
}