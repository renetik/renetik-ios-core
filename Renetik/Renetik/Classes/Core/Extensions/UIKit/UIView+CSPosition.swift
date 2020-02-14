//
// Created by Rene Dohan on 2/14/20.
//

import UIKit
import RenetikObjc

public extension UIView {
    var fromRight: CGFloat {
        get { superview.notNil ? superview!.width - (left + width) : right }
        set(value) {
            assert(superview.notNil, "Needs to have superview")
            left = superview!.width - (value + width)
        }
    }
    var fromBottom: CGFloat {
        get { superview.notNil ? superview!.height - (top + height) : bottom }
        set(value) {
            assert(superview.notNil, "Needs to have superview")
            top = superview!.height - (value + height)
        }
    }

    var leftFromRight: CGFloat { superview.notNil ? superview!.width - left : width }

    var topFromBottom: CGFloat { superview.notNil ? superview!.height - top : height }

    var absTop: CGFloat {
        get { convert(CGPoint(x: 0, y: top), to: nil).y }
        set(value) { top = convert(CGPoint(x: 0, y: value), from: nil).y }
    }

    var absBottom: CGFloat {
        get { convert(CGPoint(x: 0, y: bottom), to: nil).y }
        set(value) { bottom = convert(CGPoint(x: 0, y: value), from: nil).y }
    }

    var verticalCenter: CGFloat {
        get { center.y }
        set(value) { center = CGPoint(x: center.x, y: value) }
    }

    func verticalCenter(_ y: CGFloat) -> Self { invoke { verticalCenter = y } }

    var horizontalCenter: CGFloat {
        get { center.x }
        set(value) { center = CGPoint(x: value, y: center.y) }
    }

    func horizontalCenter(_ x: CGFloat) -> Self { invoke { horizontalCenter = x } }
}