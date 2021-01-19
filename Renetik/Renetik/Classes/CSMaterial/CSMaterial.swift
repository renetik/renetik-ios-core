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

    public let layoutFunctions: CSEvent<Void> = event()
    public let eventLayoutSubviewsFirstTime: CSEvent<Void> = event()

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

    @discardableResult
    public func layout<View: UIView>(_ view: View, function: @escaping (View) -> Void) -> View {
        layoutFunctions.listen {
            view.layoutSubviews()
            function(view)
        }
        function(view)
        return view
    }

    private var isDidLayoutSubviews = false

    override open func layoutSubviews() {
        super.layoutSubviews()
        if !isDidLayoutSubviews {
            isDidLayoutSubviews = true
            onLayoutSubviewsFirstTime()
            onCreateLayout()
            onLayoutCreated()
            eventLayoutSubviewsFirstTime.fire()
        } else {
            onUpdateLayout()
        }
        updateLayout()
        onLayoutSubviews()
    }

    open func onLayoutSubviewsFirstTime() {}

    open func onCreateLayout() {}

    open func onLayoutCreated() {}

    open func onUpdateLayout() {}

    open func onLayoutSubviews() {}

    @discardableResult
    public func updateLayout() -> Self { layoutFunctions.fire(); return self }

    lazy public var inkTouchController = { MDCRippleTouchController() }()

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
