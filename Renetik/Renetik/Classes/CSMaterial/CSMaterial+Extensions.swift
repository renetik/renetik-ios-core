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
    @objc override open func onTouchUp(_ block: @escaping Func) -> Self {
        super.onTouchUp(block)
        inkTouchController.addRipple(to: self)
        return self
    }
}

public class CSMaterialCard: MDCCard {

}

public class CSMaterialImageView: UIImageView {
    lazy var inkTouchController = { MDCRippleTouchController() }()

    @discardableResult
    @objc override open func onClick(_ block: @escaping Func) -> Self {
        super.onClick(block)
        inkTouchController.addRipple(to: self)
        return self
    }
}

public class CSMaterialLabel: UILabel {
    lazy var inkTouchController = { MDCRippleTouchController() }()

    @discardableResult
    @objc override open func onClick(_ block: @escaping Func) -> Self {
        super.onClick(block)
        inkTouchController.addRipple(to: self)
        return self
    }
}

public class CSMaterialView: CSView {

    lazy var inkTouchController = { MDCRippleTouchController() }()

    @discardableResult
    @objc override open func onClick(_ block: @escaping Func) -> Self {
        super.onClick(block)
        inkTouchController.addRipple(to: self)
        return self
    }
}

public extension MDCCard {
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

public extension MDCButton {
    @discardableResult
    override open func construct() -> Self {
        super.construct()
        clipsToBounds = false
        return self
    }
}

public extension MDCMultilineTextField {
    open override func construct() -> Self {
        super.construct()
        clipsToBounds = false
        return self
    }
}

public extension MDCTextField {
    open override func construct() -> Self {
        super.construct()
        clipsToBounds = false
        return self
    }
}
