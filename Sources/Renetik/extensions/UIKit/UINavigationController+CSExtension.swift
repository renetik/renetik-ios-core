//
// Created by Rene Dohan on 10/29/20.
//

import UIKit

private let pushKey = "UINavigationController+CSExtension.swift:PushKey"

extension UINavigationController {

    @discardableResult
    public func popViewController() -> UIViewController? {
        popViewController(animated: true)
    }

    public var last: UIViewController? {
        viewControllers.last
    }

    public var beforePrevious: UIViewController? {
        viewControllers.at(viewControllers.lastIndex - 2)
    }

    public var previous: UIViewController? {
        viewControllers.at(viewControllers.lastIndex - 1)
    }

    public var root: UIViewController? {
        viewControllers.first
    }

    @objc open func push(asRoot newRoot: UIViewController) {
        setViewControllers([newRoot], animated: true)
    }

    @discardableResult
    public func push(_ controller: UIViewController) -> UIViewController {
        pushViewController(controller, animated: true)
        return controller
    }

//    @discardableResult
//    func pop(_ controllerToPop: UIViewController) -> UIViewController {
//        if !viewControllers.contains(controllerToPop) {
//            NSException(name: "Controller is not pushed so cannot be popped").raise()
//        }
//        var toRemove = [UIViewController]()
//        for pushedController in viewControllers {
//            toRemove.add(pushedController)
//            if pushedController == controllerToPop {
//                var viewControllers = self.viewControllers
//                viewControllers.remove(toRemove)
//                setViewControllers(viewControllers, animated: true)
//            }
//        }
//
//    }

    public func pushAsLast(_ controller: UIViewController) {
        var controllers = viewControllers
        controllers[controllers.lastIndex] = controller
        setViewControllers(controllers, animated: true)
    }

    @discardableResult
    public func push(fromTop controller: UIViewController) -> UIViewController {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .moveIn //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
        transition.subtype = .fromBottom //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
        view.layer.add(transition, forKey: nil)
        pushViewController(controller, animated: false)
        return controller
    }

    public func push(_ pushingController: UIViewController, keepLast keepLastCount: Int) {
        var toRemove = [UIViewController]()
        var count = keepLastCount
        for controller in viewControllers {
            if controller.isKind(of: type(of: pushingController)) {
                if count > 0 { count -= 1 } else { toRemove.add(controller) }
            }
        }
        var viewControllers = self.viewControllers
        toRemove.each { viewControllers.remove($0) }
        viewControllers.add(pushingController)
        setViewControllers(viewControllers, animated: true)
    }

    public func contains<T: UIViewController>(controllerType: T.Type) -> Bool {
        for controller in viewControllers {
            if controller.isKind(of: controllerType) {
                return true
            }
        }
        return false
    }

    public func push(_ pushId: String, _ pushingController: UIViewController) {
        pushingController.associatedDictionary[pushKey] = pushId
        var toRemove = [UIViewController]()
        for controller in viewControllers.reversed() {
            toRemove.add(controller)
            if controller.associatedDictionary[pushKey] as? String == pushId {
                var viewControllers = self.viewControllers
                toRemove.each { viewControllers.remove($0) }
                viewControllers.add(pushingController)
                setViewControllers(viewControllers, animated: true)
                return
            }
        }
        push(pushingController)
    }

}
