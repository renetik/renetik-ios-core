//
//  File.swift
//  Renetik
//
//  Created by Rene Dohan on 3/9/19.
//

import UIKit
import RenetikObjc

public extension UIButton {

    @discardableResult
    class func construct(_ image: UIImage) -> Self { construct().image(image) }

    @discardableResult
    override open func construct() -> Self {
        super.construct().aspectFit().resizeToFit()
        return self
    }

    @discardableResult
    public func alignContent(_ alignment: ContentHorizontalAlignment) -> Self {
        contentHorizontalAlignment = alignment
        return self
    }

    public var text: String {
        get { title(for: .normal) ?? "" }
        set(value) { text(value) }
    }

    @discardableResult
    func fontStyle(_ style: UIFont.TextStyle) -> Self {
        titleLabel?.fontStyle = style
        return self
    }

    @discardableResult
    public func text(_ title: String) -> Self {
        setTitle(title, for: .normal)
        return self
    }

    @discardableResult
    public func image(_ image: UIImage) -> Self {
        setImage(image, for: .normal)
        return self
    }

    @discardableResult
    func textColor(_ color: UIColor) -> Self {
        setTitleColor(color, for: .normal)
        return self
    }

    @discardableResult
    override func aspectFit() -> Self {
        imageView?.aspectFit()
        return self
    }

    @discardableResult
    override func aspectFill() -> Self {
        imageView?.aspectFill()
        return self
    }

    func floatingDown() -> Self {
        from(bottom: 25, right: 25)
        if UIDevice.isTablet { resizeBy(padding: 5) }
        imageEdgeInsets = UIEdgeInsets(UIDevice.isTablet ? 20 : 15)
        return self
    }

    func floatingUp() -> Self {
        from(top: 25, right: 25)
        if UIDevice.isTablet { resizeBy(padding: 5) }
        imageEdgeInsets = UIEdgeInsets(UIDevice.isTablet ? 20 : 15)
        return self
    }
}
