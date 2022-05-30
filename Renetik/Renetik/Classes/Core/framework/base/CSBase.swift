//
// Created by Rene Dohan on 29/05/22.
//

import Foundation

open class CSBase: CSEventOwnerHasDestroy {
    public init(parent: CSHasDestroy? = nil) {
        parent?.also {
            register($0.eventDestroy.listenOnce { [unowned self] in onDestroy() })
        }
    }

    public var eventDestroy = event()
    public let registrations = CSRegistrations()
    private(set) var isDestroyed: Boolean = false

    public func onDestroy() {
        registrations.cancel()
        isDestroyed = true
        eventDestroy.fire().clear()
    }
}