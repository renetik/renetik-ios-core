//
// Created by Rene Dohan on 1/29/20.
//

import UIKit
import RenetikObjc

public extension UIView {

    @discardableResult
    func defaultSize() -> Self { width(UIScreen.width, height: UIScreen.height) }

    public var availableHeight: CGFloat { height - navigation.navigationBar.bottom }

    @discardableResult
    public func heightByLastSubview(padding: CGFloat = 0) -> Self {
        let lastSubViewBottom = content?.subviews.last?.bottom ?? subviews.last?.bottom ?? 0
        height = lastSubViewBottom > 0 ? lastSubViewBottom + padding : 0
        return self
    }

    @discardableResult
    func size(_ size: CGFloat) -> Self { width(size, height: size) }

    @discardableResult
    func size(_ size: CGSize) -> Self { invoke { self.size = size } }

    @discardableResult
    func size(_ width: CGFloat, _ height: CGFloat) -> Self { self.width(width, height: height) }

    var size: CGSize {
        get { frame.size }
        set(size) { frame = CGRect(x: frame.x, y: frame.y, width: size.width, height: size.height) }
    }

    @discardableResult
    func resizeToFitSubviews() -> Self { size(calculateSizeFromSubviews()) }

    func calculateSizeFromSubviews() -> CGSize {
        var rect = CGRect.zero
        subviews.each { view in rect = rect.union(view.frame) }
        return rect.size
    }

    @discardableResult
    func frame(_ rect: CGRect) -> Self { invoke { self.frame = rect } }

    @discardableResult
    func width(_ width: CGFloat, height: CGFloat) -> Self {
        size(CGSize(width: width, height: height))
        return self
    }

}
