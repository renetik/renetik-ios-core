//
// Created by Rene Dohan on 12/27/20.
//

import Foundation

public func function(if boolean: Bool, function: Func) -> CSConditionalResult {
    if boolean { function() }
    return CSConditionalResult(doElseIf: boolean == false)
}

func functionTest() {
    let A = "A"
    let B = "B"
    function(if: A == B) {
        logInfo("A == B")
    }.elseDo {
        logInfo("A != B")
    }
}
