//
//  Created by Rene Dohan on 3/18/19.
//  Copyright © 2019 Renetik. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents
import Renetik

public class CSMaterialButton: UIButton {
    lazy var inkTouchController = { MDCRippleTouchController() }()

    @discardableResult
    override open func onClick(_ block: @escaping Func) -> Self {
        // later was needed for ripple, it was not returned back to normal
        // after click when there was html rendering in click callback
        super.onClick { later { block() } }
        interaction(enabled: true)
        inkTouchController.addRipple(to: self)
        inkTouchController.rippleView.rippleStyle = .unbounded
        clipsToBounds()
        return self
    }
}

public class CSMaterialCard: MDCCard {}

public class CSMaterialImageView: UIImageView {
    lazy var inkTouchController = { MDCRippleTouchController() }()

    @discardableResult
    override open func onClick(_ block: @escaping Func) -> Self {
        // later was needed for ripple, it was not returned back to normal
        // after click when there was html rendering in click callback
        super.onClick { later { block() } }
        interaction(enabled: true)
        inkTouchController.addRipple(to: self)
        inkTouchController.rippleView.rippleStyle = .unbounded
        clipsToBounds()
        return self
    }
}

public class CSMaterialLabel: UILabel {
    lazy var inkTouchController = { MDCRippleTouchController() }()

    @discardableResult
    override open func onClick(_ block: @escaping Func) -> Self {
        // later was needed for ripple, it was not returned back to normal
        // after click when there was html rendering in click callback
        super.onClick { later { block() } }
        interaction(enabled: true)
        inkTouchController.addRipple(to: self)
        inkTouchController.rippleView.rippleStyle = .unbounded
        clipsToBounds()
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
        onCreateLayout()
        onLayoutCreated()
        return self
    }

    @discardableResult
    public func layout(function: @escaping Func) -> Self {
        layoutFunctions.listen { function() }
        function()
        return self
    }

    @discardableResult
    public func layout(function: @escaping (Self) -> Void) -> Self {
        layoutFunctions.listen { function(self) }
        function(self)
        return self
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        onLayoutSubviews()
    }

    @discardableResult
    open override func heightToFit() -> Self {
        content!.heightToFit()
        let masks = saveAndClearSubviewsAutoresizingMasks()
        height(content!.height)
        restoreSubviewsAutoresizing(masks: masks)
        return self
    }

    @discardableResult
    open override func resizeToFit() -> Self {
        content!.resizeToFit()
        let masks = saveAndClearSubviewsAutoresizingMasks()
        size(content!.size)
        restoreSubviewsAutoresizing(masks: masks)
        return self
    }

    lazy public var inkTouchController = { MDCRippleTouchController() }()

    @discardableResult
    override open func onClick(_ block: @escaping Func) -> Self {
        super.onClick(block)
        interaction(enabled: true)
        inkTouchController.addRipple(to: self)
        inkTouchController.rippleView.rippleStyle = .unbounded
        clipsToBounds()
        return self
    }

    @discardableResult
    override open func onTouchUp(_ block: @escaping Func) -> Self {
        super.onTouchUp(block)
        interaction(enabled: true)
        inkTouchController.addRipple(to: self)
        inkTouchController.rippleView.rippleStyle = .unbounded
        clipsToBounds()
        return self
    }

    @discardableResult
    override open func onTouchDown(_ block: @escaping Func) -> Self {
        super.onTouchDown(block)
        interaction(enabled: true)
        inkTouchController.addRipple(to: self)
        inkTouchController.rippleView.rippleStyle = .unbounded
        clipsToBounds()
        return self
    }
}