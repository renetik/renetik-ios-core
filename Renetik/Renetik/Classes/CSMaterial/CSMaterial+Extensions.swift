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
import RenetikObjc

public class CSMaterialButton: UIButton {
    lazy var inkTouchController = { MDCRippleTouchController() }()

    @discardableResult
    override open func onTouchUp(_ block: @escaping Func) -> Self {
        super.onTouchUp(block)
        inkTouchController.addRipple(to: self)
        return self
    }
}

public class CSMaterialCard: MDCCard {}

public class CSMaterialImageView: UIImageView {
    lazy var inkTouchController = { MDCRippleTouchController() }()

    @discardableResult
    override open func onClick(_ block: @escaping Func) -> Self {
        super.onClick(block)
        inkTouchController.addRipple(to: self)
        return self
    }
}

public class CSMaterialLabel: UILabel {
    lazy var inkTouchController = { MDCRippleTouchController() }()

    @discardableResult
    override open func onClick(_ block: @escaping Func) -> Self {
        super.onClick(block)
        inkTouchController.addRipple(to: self)
        return self
    }
}

public class CSMaterialControl: UIControl {

    lazy var inkTouchController = { MDCRippleTouchController() }()

    @discardableResult
    override open func onClick(_ block: @escaping Func) -> Self {
        super.onClick(block)
        isUserInteractionEnabled = true
        inkTouchController.addRipple(to: self)
        return self
    }

    @discardableResult
    override open func onTouchUp(_ block: @escaping Func) -> Self {
        super.onTouchUp(block)
        isUserInteractionEnabled = true
        inkTouchController.addRipple(to: self)
        return self
    }

    @discardableResult
    override open func onTouchDown(_ block: @escaping Func) -> Self {
        super.onTouchDown(block)
        isUserInteractionEnabled = true
        inkTouchController.addRipple(to: self)
        return self
    }
}

public extension MDCCard {
    @discardableResult
    override open func construct() -> Self {
        super.construct()
        clipsToBounds = false
        isInteractable = false
        return self
    }

    @discardableResult
    override open func onTouchUp(_ block: @escaping Func) -> Self {
        super.onTouchUp(block)
        isInteractable = true
        isUserInteractionEnabled = true
        return self
    }

    @discardableResult
    override open func onTap(_ block: @escaping Func) -> Self {
        super.onTap(block)
        isInteractable = true
        isUserInteractionEnabled = true
        return self
    }

    @discardableResult
    override open func onTouchDown(_ block: @escaping Func) -> Self {
        super.onTouchDown(block)
        isInteractable = true
        isUserInteractionEnabled = true
        return self
    }
}

extension MDCFloatingButton {
    override open func construct() -> Self {
        super.construct()
        clipsToBounds = false
        return self
    }
}

public extension MDCButton {
    @discardableResult
    override open func construct() -> Self {
        super.construct()
        clipsToBounds = false
        return self
    }
}

public extension MDCMultilineTextField {
    override open func construct() -> Self {
        super.construct()
        clipsToBounds = false
        return self
    }
}

public extension MDCTextField {
    override open func construct() -> Self {
        super.construct()
        clipsToBounds = false
        return self
    }
}
