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

    class func construct(color: UIColor) -> Self {
        construct().background(color)
    }

    class func construct(frame: CGRect) -> Self {
        construct().frame(frame)
    }

    class func construct() -> Self { Self().construct() }

    @discardableResult
    func visible(if condition: Bool) -> Self { invoke { self.visible = condition } }

    func invoke(animated: Bool, duration: TimeInterval = 0.3, operation: @escaping () -> Void) {
        if animated { UIView.animate(withDuration: duration, animations: operation) } else { operation() }
    }

    public func invoke(animated: Bool, duration: TimeInterval = 0.3,
                       operation: @escaping () -> Void, completion: @escaping () -> Void) {
        if animated {
            UIView.animate(withDuration: duration, animations: operation,
                    completion: { _ in completion() })
        } else {
            operation()
            completion()
        }
    }

    /** Overriding non-@objc declarations from extensions is not supported **/
    @discardableResult
    @objc func onClick(_ block: @escaping () -> Void) -> Self {
        onTap { block() }
        return self
    }

    /** Overriding non-@objc declarations from extensions is not supported **/
    @discardableResult
    @objc func onTap(_ block: @escaping () -> Void) -> Self {
        isUserInteractionEnabled = true
        bk_(whenTapped: { block() })
        return self
    }
}