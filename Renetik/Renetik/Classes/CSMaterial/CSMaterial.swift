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
    open override func construct() -> Self {
        super.construct().defaultSize().withContent()
        content!.interaction(enabled: false)
        return self
    }

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

    @discardableResult
    @objc open override func heightToFit() -> Self {
        content!.heightToFitSubviews()
        let masks = saveAndClearSubviewsAutoresizingMasks()
        height(content!.height)
        restoreSubviewsAutoresizing(masks: masks)
        return self
    }

    @discardableResult
    @objc open override func resizeToFit() -> Self {
        content!.resizeToFitSubviews()
        let masks = saveAndClearSubviewsAutoresizingMasks()
        size(content!.size)
        restoreSubviewsAutoresizing(masks: masks)
        return self
    }
}
