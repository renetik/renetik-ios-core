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

open class CSMaterialControl: UIControl {

    @discardableResult
    public override class func construct(defaultSize: Bool = true) -> Self {
        let _self: Self = Self()
        if defaultSize { _self.defaultSize() }
        _self.construct()
        return _self
    }

    @discardableResult
    public class func construct(_ function: ArgFunc<CSMaterialControl>) -> Self {
        let _self = construct()
        function(_self)
        return _self
    }

    @discardableResult
    open override func construct() -> Self {
        super.construct().defaultSize().withContent().clipsToBounds()
        content!.interaction(enabled: false)
        return self
    }

    lazy var inkTouchController = { MDCRippleTouchController() }()

    @discardableResult
    override open func onClick(_ block: @escaping Func) -> Self {
        super.onClick(block)
        interaction(enabled: true)
        inkTouchController.addRipple(to: self)
        return self
    }

    @discardableResult
    override open func onTouchUp(_ block: @escaping Func) -> Self {
        super.onTouchUp(block)
        interaction(enabled: true)
        inkTouchController.addRipple(to: self)
        return self
    }

    @discardableResult
    override open func onTouchDown(_ block: @escaping Func) -> Self {
        super.onTouchDown(block)
        interaction(enabled: true)
        inkTouchController.addRipple(to: self)
        return self
    }

    @discardableResult
    @objc open override func heightToFit() -> Self {
        content!.heightToFit()
        let masks = saveAndClearSubviewsAutoresizingMasks()
        height(content!.height)
        restoreSubviewsAutoresizing(masks: masks)
        return self
    }

    @discardableResult
    @objc open override func resizeToFit() -> Self {
        content!.resizeToFit()
        let masks = saveAndClearSubviewsAutoresizingMasks()
        size(content!.size)
        restoreSubviewsAutoresizing(masks: masks)
        return self
    }
}
