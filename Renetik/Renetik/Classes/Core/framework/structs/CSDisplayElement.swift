//
// Created by Rene Dohan on 1/13/20.
//

import UIKit

public struct CSDisplayElement {
    public let view: UIView?, item: UIBarButtonItem?

    public init(view: UIView?) { self.view = view; self.item = nil }

    public init(item: UIBarButtonItem?) { self.item = item; self.view = nil }
}