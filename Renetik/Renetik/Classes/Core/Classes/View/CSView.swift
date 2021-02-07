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

    @discardableResult
    open override func construct() -> Self {
        super.construct().defaultSize()
        onCreateLayout()
        onLayoutCreated()
        return self
    }

    open func onCreateLayout() {}

    open func onLayoutCreated() {}

    public let layoutFunctions: CSEvent<Void> = event()

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

    override open func layoutSubviews() {
        super.layoutSubviews()
        layoutFunctions.fire()
        onLayoutSubviews()
    }

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

public extension CSView {
    class func wrap(flexible leftView: UIView, margin: CGFloat = 0, fixed rightView: UIView) -> Self {
        Self.construct {
            $0.add(view: rightView).from(right: 0).centeredVertical()
            $0.layout($0.add(view: leftView).from(left: 0).fill(to: rightView, right: margin)) {
                $0.heightToFit().centeredVertical()
            }
        }.resizeToFit()
    }

// questionable if can be used... layout was collapsed for some reason...
    class func wrap(flexible leftView: UIView, margin: CGFloat = 0, flexible rightView: UIView) -> Self {
        Self.construct {
            $0.layout($0.add(view: leftView).from(left: 0)) {
                $0.width(($0.width - margin) / 2).heightToFit()
            }
            $0.layout($0.add(view: rightView)) {
                $0.fromPrevious(left: margin).width(($0.width - margin) / 2).heightToFit()
            }
        }.resizeToFit()
    }


}

public extension CSView {
    func wrap(flexible leftView: UIView, margin: CGFloat = 0, flexible rightView: UIView) -> UIView {
        CSView.construct {
            layout($0.add(view: leftView).from(left: 0)) {
                $0.width(($0.width - margin) / 2).heightToFit()
            }
            layout($0.add(view: rightView)) {
                $0.fromPrevious(left: margin).width(($0.width - margin) / 2).heightToFit()
            }
        }
    }


//    func wrap(fixedLeft: UIView, margin: CGFloat = 0, toFitRight: UIView) -> CSView {
//        CSView.construct {
//            layout($0.add(view: fixedLeft).from(left: 0)) {
//                $0.centeredVertical()
//            }
//            layout($0.add(view: toFitRight)) {
//                $0.fromPrevious(left: margin).resizeToFit().centeredVertical()
//            }
//        }.resizeToFit()
//    }
}