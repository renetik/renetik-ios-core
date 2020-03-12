//
// Created by Rene on 2018-11-22.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

import UIKit
import RenetikObjc
import BlocksKit

public extension UIView {

    class func construct(owner: NSObject? = nil, xib: String) -> Self {
        let arrayOfXibObjects = Bundle.main.loadNibNamed(xib, owner: owner, options: nil)
        let instance = (arrayOfXibObjects?[0] as? Self)?.construct()
        return instance!
    }

    class func construct(width: CGFloat, height: CGFloat) -> Self {
        construct().width(width, height: height)
    }

    class func construct(width: CGFloat) -> Self {
        construct().width(width)
    }

    class func construct(color: UIColor) -> Self {
        construct().background(color)
    }

    class func construct(frame: CGRect) -> Self {
        construct().frame(frame)
    }

    class func construct() -> Self { Self().construct() }

    @discardableResult
    @objc open func construct() -> Self {
        clipsToBounds().setAutoresizingDefaults()
    }

    @discardableResult
    @objc func visible(if condition: Bool) -> Self { invoke { self.isVisible = condition } }


    /** Overriding non-@objc declarations from extensions is not supported **/
    @discardableResult
    @objc open func onClick(_ block: @escaping () -> Void) -> Self {
        onTap { block() }
        return self
    }

    /** Overriding non-@objc declarations from extensions is not supported **/
    @discardableResult
    @objc open func onTap(_ block: @escaping () -> Void) -> Self {
        isUserInteractionEnabled = true
        bk_(whenTapped: { block() })
        return self
    }

    @discardableResult
    @objc func background(_ color: UIColor) -> Self { invoke { self.backgroundColor = color } }

    @discardableResult
    @objc func tint(color: UIColor) -> Self { invoke { self.tintColor = color } }

    @discardableResult
    @objc func content(mode: UIView.ContentMode) -> Self { invoke { self.contentMode = mode } }

    @discardableResult
    @objc func clipsToBounds(_ value: Bool = true) -> Self { invoke { self.clipsToBounds = value } }

    @discardableResult
    @objc func asCircular() -> Self {
        //    let longerSide = self.width > self.width ? self.width : self.height;
        aspectFill()
        layer.cornerRadius = width / 2
        layer.masksToBounds = true
        clipsToBounds = true
        return self
    }

    @discardableResult
    @objc func roundedCorners(_ width: Int) -> Self {
        layer.cornerRadius = CGFloat(width)
        layer.masksToBounds = true
        clipsToBounds = true
        return self
    }

    @objc var isVisible: Bool {
        get { !isHidden }
        set(value) { self.isHidden = !value }
    }

    @discardableResult
    @objc func visible(_ visible: Bool) -> Self { invoke { self.isVisible = visible } }

    @discardableResult
    @objc func show() -> Self { invoke { self.isVisible = true } }

    @discardableResult
    @objc func hide() -> Self { invoke { self.isVisible = false } }

    @objc func isVisibleToUser() -> Bool {
        logInfo("window:\(window) visible:\(isVisible) alpha:\(alpha)")
        return window.notNil && isVisible && alpha > 0
    }

    @discardableResult
    @objc func aspectFit() -> Self { invoke { contentMode = .scaleAspectFit } }

    @discardableResult
    @objc func clipToBounds() -> Self { invoke { clipsToBounds = true } }

    @discardableResult
    @objc func aspectFill() -> Self { invoke { contentMode = .scaleAspectFill } }

    @discardableResult
    @objc func border(width: CGFloat, color: UIColor, radius: Int32) -> Self {
        invoke { layer.setBorder(width, color, radius) }
    }

    func clone() -> Self {
        NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! Self
    }

    var firstResponder: UIView? {
        for view in subviews {
            if view.isFirstResponder { return view }
            let childFirstResponder = view.firstResponder
            if childFirstResponder.notNil { return childFirstResponder }
        }
        return nil
    }

//    class func animationOptions(with curve: UIView.AnimationCurve) -> UIView.AnimationOptions {
//        switch curve { //Move to extension if ever needed.
//        case .easeInOut:
//            return .curveEaseInOut
//        case .easeIn:
//            return .curveEaseIn
//        case .easeOut:
//            return .curveEaseOut
//        case .linear:
//            return .curveLinear
//        @unknown default:
//            break
//        }
//        return .curveLinear
//    }

    func background(fadeTo color: UIColor) {
        if backgroundColor == color { return }
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue = backgroundColor?.cgColor
        animation.toValue = color.cgColor
        animation.duration = defaultAnimationTime
        layer.add(animation, forKey: "fadeAnimation")
        backgroundColor = color
    }

    func fadeToggle() -> Self { invoke { (isVisible && alpha == 1).then { fadeOut() }.elseDo { fadeIn() } } }

    func fadeTo(visible: Bool) { invoke { visible.isTrue { fadeIn() }.elseDo { fadeOut() } } }

    func fadeIn(duration: TimeInterval = defaultAnimationTime, onDone: (() -> Void)? = nil) {
        if isVisible && alpha == 1 { return }
        isVisible = true
        UIView.animate(withDuration: duration, delay: 0,
                options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState],
                animations: { self.alpha = 1.0 },
                completion: { _ in onDone?() })
    }

    func fadeOut(duration: TimeInterval = defaultAnimationTime, onDone: (() -> Void)? = nil) {
        if isHidden || alpha == 0 { return }
        UIView.animate(withDuration: duration, delay: 0,
                options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState],
                animations: { self.alpha = 0.0 },
                completion: { isFinished in
                    if isFinished { self.alpha = 1; self.hide() }
                    onDone?()
                })
    }

}