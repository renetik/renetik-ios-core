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

class CSMaterialButton: UIButton {
    lazy var inkTouchController = { MDCRippleTouchController() }()

    @discardableResult
    @objc override open func onTouchUp(_ block: @escaping Func) -> Self {
        super.onTouchUp(block)
        inkTouchController.addRipple(to: self)
        return self
    }
}

class CSMaterialCard: MDCCard {

}

class CSMaterialImageView: UIImageView {
    lazy var inkTouchController = { MDCRippleTouchController() }()

    @discardableResult
    @objc override open func onClick(_ block: @escaping Func) -> Self {
        super.onClick(block)
        inkTouchController.addRipple(to: self)
        return self
    }
}

class CSMaterialLabel: UILabel {
    lazy var inkTouchController = { MDCRippleTouchController() }()

    @discardableResult
    @objc override open func onClick(_ block: @escaping Func) -> Self {
        super.onClick(block)
        inkTouchController.addRipple(to: self)
        return self
    }
}

class CSMaterialView: CSView {

    lazy var inkTouchController = { MDCRippleTouchController() }()

    @discardableResult
    @objc override open func onClick(_ block: @escaping Func) -> Self {
        super.onClick(block)
        inkTouchController.addRipple(to: self)
        return self
    }
}

extension MDCCard {
    @discardableResult
    open override func construct() -> Self {
        super.construct()
        clipsToBounds = false
        isInteractable = false
        return self
    }

    @discardableResult
    open override func onTouchUp(_ block: @escaping Func) -> Self {
        super.onTouchUp(block)
        isInteractable = true
        isUserInteractionEnabled = true
        return self
    }

    @discardableResult
    open override func onTap(_ block: @escaping Func) -> Self {
        super.onTap(block)
        isInteractable = true
        isUserInteractionEnabled = true
        return self
    }

    @discardableResult
    open override func onTouchDown(_ block: @escaping Func) -> Self {
        super.onTouchDown(block)
        isInteractable = true
        isUserInteractionEnabled = true
        return self
    }
}

extension MDCFloatingButton {
    open override func construct() -> Self {
        super.construct()
        clipsToBounds = false
        return self
    }
}

extension MDCButton {
    @discardableResult
    override open func construct() -> Self {
        super.construct()
        clipsToBounds = false
        return self
    }
}

extension MDCMultilineTextField {
    open override func construct() -> Self {
        super.construct()
        clipsToBounds = false
        return self
    }
}

extension MDCTextField {
    open override func construct() -> Self {
        super.construct()
        clipsToBounds = false
        return self
    }
}
