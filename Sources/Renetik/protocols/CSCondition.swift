//
// Created by Rene Dohan on 11/25/20.
//

import Foundation

public protocol CSConditionProtocol {
    func evaluate() -> Bool?
}

public class CSCondition: CSConditionProtocol {
    let function: () -> Bool?

    public init(_ function: @escaping () -> Bool?) {
        self.function = function
    }

    public func evaluate() -> Bool? { function() }
}