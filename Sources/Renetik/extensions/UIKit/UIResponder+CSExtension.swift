//
// Created by Rene Dohan on 3/4/20.
//

import UIKit

public extension UIResponder {

    var safeArea: UIEdgeInsets { delegate.window!.safeAreaInsets }

    func invoke(animated: Bool, duration: TimeInterval = .defaultAnimation, operation: @escaping Func) {
        if animated { UIView.animate(withDuration: duration, animations: operation) } else { operation() }
    }

    func invoke(animated: Bool, duration: TimeInterval = .defaultAnimation,
                operation: @escaping Func, completion: @escaping Func) {
        if animated {
            UIView.animate(withDuration: duration, animations: operation, completion: { _ in completion() })
        } else {
            operation()
            completion()
        }
    }

    func animate(duration: TimeInterval = .defaultAnimation, operation: @escaping Func, completion: Func? = nil) {
        UIView.animate(withDuration: duration, animations: operation, completion: { _ in completion?() })
    }

}
