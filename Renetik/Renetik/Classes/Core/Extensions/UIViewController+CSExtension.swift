//
//  UIViewController+CSExtension.swift
//  Renetik
//
//  Created by Rene Dohan on 2/19/19.
//

import RenetikObjc
import UIKit

public extension UIViewController {
    @discardableResult
    public func push() -> Self {
        navigation.push(self)
        return self
    }

    @discardableResult
    public func pushFromTop() -> Self {
        navigation.push(fromTop: self)
        return self
    }

    @discardableResult
    func showChild(controller: UIViewController) -> UIViewController {
        showChild(controller: controller, parentView: view)
    }

    func showChildUnderLast(controller: UIViewController) -> UIViewController {
        view.verticalLine(add: controller.view)
        showChild(controller: controller, parentView: view)
        return controller
    }

    func showChildNextLast(controller: UIViewController, parentView: UIView) -> UIViewController {
        view.horizontalLineAdd(controller.view)
        showChild(controller: controller, parentView: parentView)
        return controller
    }

    @discardableResult
    func showChild(controller: UIViewController, parentView: UIView?) -> UIViewController {
        addChild(controller)
        parentView?.addSubview(controller.view)
        controller.didMove(toParent: self)
        (controller as? CSMainController)?.isShowing = true
        return controller
    }

    @discardableResult
    func addChild(controller: UIViewController) -> UIViewController {
        showChild(controller: controller, parentView: nil)
    }

    @objc open func dismissChild(controller: UIViewController) -> UIViewController {
        controller.willMove(toParent: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParent()
        (controller as? CSMainController)?.isShowing = false
        return controller
    }
}

