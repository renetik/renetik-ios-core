//
// Created by Rene Dohan on 12/29/19.
//

import Foundation

public extension Bool {
    var isTrue: Bool { self == true }
    var isFalse: Bool { self == false }

    func then(_ function: () -> Void) -> CSConditionalResult {
        if isTrue { function() }
        return CSConditionalResult(doElseIf: isFalse)
    }

    func isTrue(_ function: () -> Void) -> CSConditionalResult {
        if isTrue { function() }
        return CSConditionalResult(doElseIf: isFalse)
    }
}

public extension Optional where Wrapped == Bool {
    var isTrue: Bool { self == true }
    var isFalse: Bool { self == false }
}