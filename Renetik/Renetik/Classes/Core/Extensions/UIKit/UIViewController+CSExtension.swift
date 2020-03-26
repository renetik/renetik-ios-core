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
    func showChild(controller: UIViewController, parentView: UIView) -> UIViewController {
        addChild(controller)
        parentView.add(controller.view)
        controller.didMove(toParent: self)
        (controller as? CSViewController)?.isShowing = true
        return controller
    }

    @discardableResult
    func addChild(controller: UIViewController) -> UIViewController {
        addChild(controller)
        controller.didMove(toParent: self)
        (controller as? CSViewController)?.isShowing = true
        return controller
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

    var isDarkMode: Bool {
        if #available(iOS 12, *) { return traitCollection.isDarkMode } else { return false }
    }

    func findControllerInNavigation() -> UIViewController? {
        var foundController: UIViewController? = self
        while foundController.notNil && foundController?.parent != navigation {
            foundController = foundController?.parent
        }
        return foundController?.parent == navigation ? foundController : nil
    }

    var isLastInNavigation: Bool { navigation.last == self }

    @discardableResult
    func backButtonWithoutPreviousTitle() -> Self {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        return self
    }

    @discardableResult
    func backButtonTitle(_ title: String?) -> Self {
        navigationItem.backBarButtonItem?.title = title; return self
    }

    @discardableResult
    func present(_ modalViewController: UIViewController) -> Self {
        present(modalViewController, animated: true); return self
    }

    @discardableResult
    func dismiss() -> Self { dismiss(animated: true); return self }
}