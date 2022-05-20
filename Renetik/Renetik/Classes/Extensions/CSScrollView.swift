//
// Created by Rene Dohan on 12/22/19.
//

import UIKit
import TPKeyboardAvoiding

open class CSScrollView: TPKeyboardAvoidingScrollView, CSHasLayoutProtocol {

    @discardableResult
    public class func construct() -> Self { construct(defaultSize: true) }

    @discardableResult
    public class func construct(_ function: ArgFunc<CSScrollView>) -> Self {
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
    public func layout<View: UIView>(_ view: View, function: @escaping (View) -> Void) -> View {
        layoutFunctions.listen { function(view) }
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
    public func updateLayout() -> Self { animate { self.layoutFunctions.fire() }; return self }
}

public extension CSScrollView {

    @discardableResult
    func layout<View: UIView>(footer view: View, margin: CGFloat, function: @escaping ArgFunc<View>) -> View {
        layout { [unowned self] in
            function(view)
            if view.bottom < safeHeight {
                view.flexibleTop().from(safeBottom: 0) //navigation.navigationBar.bottom
            } else {
                contentSize(height: view.bottom)
            }
        }
        return view
    }

    @discardableResult
    func layout<View: UIView>(footer view: View, margin: CGFloat) -> View {
        layout(footer: view, margin: margin) { $0.fromPrevious(top: margin).heightToFit() }
    }
}
