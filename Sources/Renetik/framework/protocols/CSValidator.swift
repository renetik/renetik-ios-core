//
// Created by Rene Dohan on 11/24/20.
//

import Foundation

public protocol CSValidatorProtocol {
    func validate() -> Bool?
    var hint: String { get }
}

public func validator(_ function: @escaping () -> Bool?) -> CSValidatorProtocol {
    CSValidatorImplementation(function)
}

class CSValidatorImplementation: CSValidatorProtocol {
    let function: () -> Bool?

    init(_ function: @escaping () -> Bool?) { self.function = function }

    func validate() -> Bool? { function() }

    private(set) var hint: String = ""
}

public class CSVariableValidator<T, Variable: CSProperty>: CSValidatorProtocol {

    let variable: Variable
    let function: (T) -> Bool

    public init(_ variable: Variable, _ function: @escaping (T) -> Bool) {
        self.variable = variable; self.function = function
    }

    public func validate() -> Bool? { function(variable.value as! T) }

    private(set) public var hint: String = ""
}