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
        parentView?.add(controller.view)
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

    func popover(from element: CSDisplayElement) -> Self {
        modalPresentationStyle = .popover
        element.view.notNil {
            popoverPresentationController?.sourceRect = $0.frame
            popoverPresentationController?.sourceView = $0.superview;
        }.elseDo { popoverPresentationController?.barButtonItem = element.item! }
        return self
    }

    @available(iOS 12.0, *)
    var isDarkMode: Bool { traitCollection.isDarkMode }

    func findControllerInNavigation() -> UIViewController? {
        var foundController: UIViewController? = self
        while foundController.notNil && foundController?.parent != navigation {
            foundController = foundController?.parent
        }
        return foundController?.parent == navigation ? foundController : nil
    }
}