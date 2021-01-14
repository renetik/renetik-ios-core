//
// Created by Rene Dohan on 12/22/19.
//

import UIKit

open class CSView: UIControl, CSHasLayoutProtocol {

    @discardableResult
    public class func construct() -> Self { construct(defaultSize: true) }

    @discardableResult
    public class func construct(_ function: ArgFunc<CSView>) -> Self {
        let _self = construct(defaultSize: true)
        function(_self)
        return _self
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

    @discardableResult
    open override func heightToFit() -> Self {
        if content.notNil {
            content!.heightToFit()
            let masks = saveAndClearSubviewsAutoresizingMasks()
            height(content!.height)
            restoreSubviewsAutoresizing(masks: masks)
        } else {
            heightToFitSubviews()
        }
        return self
    }

    @discardableResult
    open override func resizeToFit() -> Self {
        if content.notNil {
            content!.resizeToFit()
            let masks = saveAndClearSubviewsAutoresizingMasks()
            size(content!.size)
            restoreSubviewsAutoresizing(masks: masks)
        } else {
            resizeToFitSubviews()
        }
        return self
    }
}