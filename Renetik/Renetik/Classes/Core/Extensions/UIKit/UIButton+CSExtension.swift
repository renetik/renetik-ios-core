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
    override open func construct() -> Self {
        super.construct()
        aspectFit()
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

    @discardableResult
    public class func floating(in view: UIView, _ image: UIImage, _ onClick: @escaping (UIButton) -> Void) -> Self {
        let button = self.init().construct()
        view.add(view: button.resizeToFit().onTouchUp { it in onClick(button) })
        return button.image(image).from(right: 25).from(bottom: 25).flexibleLeftTop()
    }
}
