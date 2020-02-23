//
//  UIViewController+CSExtension.swift
//  Renetik
//
//  Created by Rene Dohan on 2/19/19.
//

import Foundation
import UIKit
import RenetikObjc

public extension UIViewController {

    func invoke(animated: Bool, duration: TimeInterval = 0.3, operation: @escaping () -> Void) {
        view.invoke(animated: animated, duration: duration, operation: operation)
    }

    func invoke(animated: Bool, duration: TimeInterval = 0.3,
                operation: @escaping () -> Void, completion: @escaping () -> Void) {
        view.invoke(animated: animated, duration: duration,
                operation: operation, completion: completion)
    }

    @discardableResult
    func push() -> Self {
        navigation.push(self)
        return self
    }

    @discardableResult
    func pushFromTop() -> Self {
        navigation.push(fromTop: self)
        return self
    }

    @discardableResult
    func showChild(controller: UIViewController) -> UIViewController {
        showChild(controller: controller, parentView: view)
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

    func popoverFrom(view: UIView? = nil, item: UIBarButtonItem? = nil) -> Self {
        modalPresentationStyle = .popover
        view.notNil {
            popoverPresentationController?.sourceRect = $0.frame
            popoverPresentationController?.sourceView = $0.superview;
        }.elseDo { popoverPresentationController?.barButtonItem = item }
        return self
    }

    @available(iOS 12.0, *)
    var isDarkMode: Bool { traitCollection.isDarkMode }

    func findControllerInNavigation() -> UIViewController? {
        if parent == navigation { return self }
        var controller: UIViewController? = self
        repeat {
            controller = controller?.parent
        } while controller.notNil && controller?.parent != navigationController
        return controller
    }
}