//
//  File.swift
//  Renetik
//
//  Created by Rene Dohan on 3/9/19.
//

import UIKit

public extension UIButton {

    @discardableResult
    class func construct(image: UIImage) -> Self { construct().image(image) }

    @discardableResult
    override func construct() -> Self {
        super.construct().aspectFit().resizeToFit()
        return self
    }

    @discardableResult
    func alignContent(_ alignment: ContentHorizontalAlignment) -> Self {
        contentHorizontalAlignment = alignment
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

    func floatingDown(distance: CGFloat = 25) -> Self {
        from(bottom: distance, right: distance)
        if UIDevice.isTablet { resize(padding: 5) }
        imageEdgeInsets = UIEdgeInsets(UIDevice.isTablet ? 20 : 15)
        return self
    }

    func floatingUp(distance: CGFloat = 25) -> Self {
        from(top: distance, right: distance)
        if UIDevice.isTablet { resize(padding: 5) }
        imageEdgeInsets = UIEdgeInsets(UIDevice.isTablet ? 20 : 15)
        return self
    }
}

extension UIButton: CSHasTextProtocol {
    public func text() -> String? { title(for: .normal) }

    public func text(_ text: String?) { setTitle(text, for: .normal) }
}

extension UIButton: CSHasFontProtocol {
    public func font() -> UIFont? { titleLabel?.font }

    public func font(_ font: UIFont?) { titleLabel?.font = font }
}

extension UIButton: CSHasImageProtocol {
    public func image() -> UIImage? { image(for: .normal) }

    public func image(_ image: UIImage?) { setImage(image, for: .normal) }
}

extension UIButton: CSHasAttributedTextProtocol {
    public func attributedText() -> NSAttributedString? { attributedTitle(for: .normal) }

    public func attributed(text: NSAttributedString?) { setAttributedTitle(text, for: .normal) }
}

extension UIButton: CSHasTextColorProtocol {
    public func textColor() -> UIColor? { titleColor(for: .normal) }

    @discardableResult
    public func text(color: UIColor?) -> Self { setTitleColor(color, for: .normal); return self }
}
