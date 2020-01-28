//
//  File.swift
//  Renetik
//
//  Created by Rene Dohan on 3/9/19.
//

import UIKit
import RenetikObjc

public extension UIButton {
    public func alignContent(_ alignment: ContentHorizontalAlignment) -> Self {
        contentHorizontalAlignment = alignment
        return self
    }

    public var text: String {
        get { title() }
        set(value) { title(value) }
    }

    public class func floating(in view: UIView, _ image: UIImage, _ onClick: @escaping (UIButton) -> Void) -> Self {
        let button = self.init().construct()
        view.add(view: button.resizeToFit().onTouchUp { it in onClick(button) })
        return button.image(image).from(right: 25).from(bottom: 25).flexibleLeftTop()
    }

//    @discardableResult
//    override func onClick(_ block: @escaping () -> Void) -> Self {
//        isUserInteractionEnabled = true
//        onTap { _ in
//            block()
//        }
//        onTouchDown { _ in
//            block()
//        }
//        onTouchUp { _ in
//            block()
//        }
//        return self
//    }


}
