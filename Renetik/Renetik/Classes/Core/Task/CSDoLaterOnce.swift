//
// Created by Rene Dohan on 1/1/21.
//

import Foundation

public class CSDoLaterOnce {
    let delay: TimeInterval, function: Func
    var willInvoke = false

    public init(delay: TimeInterval = 0, _ function: @escaping Func) {
        self.delay = delay; self.function = function
    }

    public func start() {
        if willInvoke { return }
        willInvoke = true
        later(seconds: delay) { [unowned self] in
            function()
            willInvoke = false
        }
    }
}