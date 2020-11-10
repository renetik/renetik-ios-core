//
// Created by Rene Dohan on 10/29/20.
//

import UIKit

public extension UINavigationController {

    @discardableResult
    func popViewController() -> UIViewController? {
        popViewController(animated: true)
    }

    var last: UIViewController? {
        viewControllers.last
    }

    var beforePrevious: UIViewController? {
        viewControllers.at(viewControllers.lastIndex - 2)
    }

    var previous: UIViewController? {
        viewControllers.at(viewControllers.lastIndex - 1)
    }

    var root: UIViewController? {
        viewControllers.first
    }

    @objc func push(asRoot newRoot: UIViewController) {
        setViewControllers([newRoot], animated: true)
    }

    @discardableResult
    func push(_ controller: UIViewController) -> UIViewController {
        pushViewController(controller, animated: true)
        return controller
    }

    @discardableResult
    func push(fromTop controller: UIViewController) -> UIViewController {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .moveIn //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
        transition.subtype = .fromBottom //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
        view.layer.add(transition, forKey: nil)
        pushViewController(controller, animated: false)
        return controller
    }

//    func push(fromBottom controller: UIViewController?) -> UIViewController? {
//    let transition = CATransition.animation
//    transition?.duration = 0.5
//    transition?.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
//    transition?.type = .moveIn //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
//    transition?.subtype = .fromTop //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
//    if let transition = transition {
//        view.layer.add(transition, forKey: nil)
//    }
//    if let controller = controller {
//        pushViewController(controller, animated: false)
//    }
//    return controller
//}
//
//func push(fromLeft controller: UIViewController?) -> UIViewController? {
//    let transition = CATransition.animation
//    transition?.duration = 0.5
//    transition?.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
//    transition?.type = .moveIn //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
//    transition?.subtype = .fromLeft //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
//    if let transition = transition {
//        view.layer.add(transition, forKey: nil)
//    }
//    if let controller = controller {
//        pushViewController(controller, animated: false)
//    }
//    return controller
//}
//
//    func push(fromRight controller: UIViewController?) -> UIViewController? {
//    let transition = CATransition.animation
//    transition?.duration = 0.5
//    transition?.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
//    transition?.type = .moveIn //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
//    transition?.subtype = .fromRight //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
//    if let transition = transition {
//        view.layer.add(transition, forKey: nil)
//    }
//    if let controller = controller {
//        pushViewController(controller, animated: false)
//    }
//    return controller
//}
//
//func pop(to viewController: UIViewController?) -> [AnyHashable]? {
//    if let viewController = viewController {
//        return popToViewController(viewController, animated: true)
//    }
//    return nil
//}
//
//func pop(toViewControllerOf viewControllerClass: AnyClass) {
//    for controller in viewControllers {
//        if controller is viewControllerClass {
//            pop(to: controller)
//            return
//        }
//    }
//    print("popToViewControllerOfClass not found controller of class \(viewControllerClass.description)")
//}
//
//    func popToViewController(before viewControllerClass: AnyClass) {
//    for i in 1..<viewControllers.count {
//        let controller = viewControllers[i]
//        if controller is viewControllerClass {
//            pop(to: viewControllers[i - 1])
//            return
//        }
//    }
//    print("popToViewControllerBefore not found controller of class \(viewControllerClass.description)")
//}
//
//func push(asSingle pushingController: UIViewController?) {
//    var toRemove: [AnyHashable] = []
//
//    for controller in self.viewControllers {
//        if controller is pushingController {
//            toRemove.put(controller)
//        }
//    }
//
//    var viewControllers = self.viewControllers
//    viewControllers = viewControllers.filter({ !toRemove.contains($0) })
//    viewControllers.put(pushingController)
//    setViewControllers(viewControllers, animated: true)
//}
//


    func push(_ pushingController: UIViewController, keepLast keepLastCount: Int) {
        var toRemove = [UIViewController]()
        var count = keepLastCount
        for controller in self.viewControllers {
            if controller.isKind(of: type(of: pushingController)) {
                if count > 0 { count -= 1 } else { toRemove.add(controller) }
            }
        }
        var viewControllers = self.viewControllers
        toRemove.each { viewControllers.remove($0) }
        viewControllers.add(pushingController)
        setViewControllers(viewControllers, animated: true)
    }

//
//    func push(_ controller: UIViewController?, _ index: Int) {
//        let range = (viewControllers as NSArray).subarray(with: NSRange(location: 0, length: index - 1))
//        var array = range
//        if let controller = controller {
//            array.append(controller)
//        }
//        if let array = array as? [UIViewController] {
//            setViewControllers(array, animated: true)
//        }
//    }
//
//    func pushViewController(asSecondOfItsKind newcontroller: UIViewController?) {
//        let index: UInt = 0
//        var firstFoundIndex = false
//        for controller in viewControllers {
//            index += 1
//            if controller is newcontroller {
//                if firstFoundIndex {
//                    push(newcontroller, index)
//                    return
//                } else {
//                    firstFoundIndex = true
//                }
//            }
//        }
//        push(newcontroller)
//    }
//
//    func pushViewController(asFirstOfItsKind newcontroller: UIViewController?) {
//        let index: UInt = 0
//        for controller in viewControllers {
//            index += 1
//            if controller is newcontroller {
//                push(newcontroller, index)
//                return
//            }
//        }
//        push(newcontroller)
//    }
//
//    func push(_ newController: UIViewController?, after afterControllerClass: AnyClass) {
//        let index: UInt = 0
//        for controller in viewControllers {
//            index += 1
//            if controller is afterControllerClass {
//                push(newController, index + 1)
//                return
//            }
//        }
//    }
//
//    func replaceLast(_ controller: UIViewController?) {
//        var viewControllers = self.viewControllers
//        viewControllers.removeLast()
//        if let controller = controller {
//            viewControllers.append(controller)
//        }
//        setViewControllers(viewControllers, animated: true)
//    }
//
//    func pushInsteadOfLast(_ controller: UIViewController?) {
//        var viewControllersToRemove: [AnyHashable] = []
//        var index = self.viewControllers.count - 1
//        while index >= 0 {
//            let pushed = self.viewControllers.at(Int(index))
//            viewControllersToRemove.put(pushed)
//            if pushed is controller {
//                break
//            }
//            index -= 1
//        }
//        var viewControllers = self.viewControllers
//        viewControllers = viewControllers.filter({ !viewControllersToRemove.contains($0) })
//        viewControllers.put(controller)
//        setViewControllers(viewControllers, animated: true)
//    }

    func contains<T: UIViewController>(controllerType: T.Type) -> Bool {
        for controller in viewControllers {
            if controller.isKind(of: controllerType) {
                return true
            }
        }
        return false
    }


}