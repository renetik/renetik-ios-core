//
// Created by Rene Dohan on 1/29/20.
//

import UIKit
import RenetikObjc

public extension UIView {

    var width: CGFloat {
        get { frame.size.width }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }

    @discardableResult
    func width(_ value: CGFloat) -> Self { invoke { self.width = value } }

    var height: CGFloat {
        get { frame.size.height }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }

    @discardableResult
    func height(_ value: CGFloat) -> Self { invoke { self.height = value } }

    @discardableResult
    func widthAsHeight() -> Self { invoke { width = height } }

    @discardableResult
    func heightAsWidth() -> Self { invoke { height = width } }

    @discardableResult
    func defaultSize() -> Self { width(UIScreen.width, height: UIScreen.height) }

    public var availableHeight: CGFloat { height - navigation.navigationBar.bottom }

    @discardableResult
    public func heightByLastSubview(padding: CGFloat = 0, minimum: CGFloat = 0) -> Self {
        let lastSubviewBottom = (content?.subviews.last?.bottom ?? subviews.last?.bottom)
        return height(lastSubviewBottom?.get { $0 + padding } ?? minimum)
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

    @discardableResult
    func add(left value: CGFloat) -> Self {
        left -= value
        width += value
        return self
    }

    @discardableResult
    func add(top value: CGFloat) -> Self {
        top -= value
        height += value
        return self
    }

    @discardableResult
    func add(right value: CGFloat) -> Self {
        width += value
        return self
    }

    @discardableResult
    func add(bottom value: CGFloat) -> Self { invoke { self.height += value } }

    @discardableResult
    func add(width value: CGFloat) -> Self { invoke { self.width += value } }

    @discardableResult
    func add(height value: CGFloat) -> Self { invoke { self.height += value } }

    @discardableResult
    func remove(width value: CGFloat) -> Self { invoke { self.width -= value } }

    @discardableResult
    func remove(height value: CGFloat) -> Self { invoke { self.height -= value } }

    @discardableResult
    func resize(padding: CGFloat) -> Self {
        if isFixedLeft() {
            add(right: padding)
        } else {
            add(left: padding)
        }
        if isFixedTop() {
            add(bottom: padding)
        } else {
            add(top: padding)
        }
        if isFixedRight() {
            add(left: padding)
        } else {
            add(right: padding)
        }
        if isFixedBottom() {
            add(top: padding)
        } else {
            add(bottom: padding)
        }
        return self
    }

    @discardableResult
    @objc open func resizeToFit() -> Self { invoke { self.sizeToFit() } }

    @discardableResult
    @objc open func widthToFit() -> Self { width(calculateWidthToFitHeight()) }

    @discardableResult
    @objc open func heightToFit() -> Self { height(calculateHeightToFitWidth()) }

    @objc open func calculateWidthToFitHeight() -> CGFloat {
        assert(height > 0, "Height has to be set to calculate width")
        return sizeThatFits(CGSize(width: .infinity, height: height)).width
    }

    @objc open func calculateHeightToFitWidth() -> CGFloat {
        assert(width > 0, "Width has to be set to calculate height")
        return sizeThatFits(CGSize(width: width, height: .infinity)).height
    }

    func hideByHeight(if condition: Bool) -> Self { invoke { if condition { self.height = 0 } } }
}
