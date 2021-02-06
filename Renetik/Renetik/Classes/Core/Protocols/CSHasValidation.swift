//
// Created by Rene Dohan on 2/5/21.
//

import Foundation

public protocol CSHasValidationProtocol {
    func validation(_ validators: [CSValidatorProtocol]) -> Bool
}

public extension CSHasValidationProtocol {
    func validation(_ validators: CSValidatorProtocol...) -> Bool { validation(validators) }
}

public extension CSHasValidationProtocol where Self: CSHasErrorProtocol {
    @discardableResult
    func validation(_ validators: [CSValidatorProtocol]) -> Bool {
        for validator in validators {
            let isValid = validator.validate()
            if isValid == nil { continue }
            if isValid.isFalse {
                error(validator.hint)
                return true
            }
        }
        errorClear()
        return false
    }
}