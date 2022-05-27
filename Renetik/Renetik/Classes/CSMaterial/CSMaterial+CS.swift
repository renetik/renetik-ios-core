//
//  MDCCard+CSExtension.swift
//  Motorkari
//
//  Created by Rene Dohan on 3/18/19.
//  Copyright © 2019 Renetik Software. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents
import Renetik

public extension MDCCard {
    @discardableResult
    override open func construct() -> Self {
        super.construct().clipsToBounds(false).also { $0.isInteractable = true }
    }

    @discardableResult
    override open func onTouchUp(_ block: @escaping Func) -> Self {
        super.onTouchUp(block).also { $0.isInteractable = true }
    }

    @discardableResult
    override open func onTap(_ block: @escaping Func) -> Self {
        super.onTap(block).also { $0.isInteractable = true }
    }

    @discardableResult
    override open func onTouchDown(_ block: @escaping Func) -> Self {
        super.onTouchDown(block).also { $0.isInteractable = true }
    }
}

extension MDCFloatingButton {
    override open func construct() -> Self {
        super.construct().clipsToBounds(false)
    }
}

public extension MDCButton {
    @discardableResult
    override open func construct() -> Self {
        super.construct().clipsToBounds(false)
    }
}

public extension MDCMultilineTextField {
    override open func construct() -> Self {
        super.construct().clipsToBounds(false)
    }
}

public extension MDCTextField {
    override open func construct() -> Self {
        super.construct().clipsToBounds(false)
    }
}