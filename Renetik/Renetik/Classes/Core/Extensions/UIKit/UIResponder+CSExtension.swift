//
// Created by Rene Dohan on 3/4/20.
//

import Foundation

public extension UIResponder {

    func invoke(animated: Bool, duration: TimeInterval = defaultAnimationTime, operation: @escaping () -> Void) {
        if animated { UIView.animate(withDuration: duration, animations: operation) } else { operation() }
    }

    func invoke(animated: Bool, duration: TimeInterval = defaultAnimationTime,
                operation: @escaping () -> Void, completion: @escaping () -> Void) {
        if animated {
            UIView.animate(withDuration: duration, animations: operation, completion: { _ in completion() })
        } else {
            operation()
            completion()
        }
    }

    func animate(duration: TimeInterval = defaultAnimationTime, operation: @escaping () -> Void) {
        UIView.animate(withDuration: duration, animations: operation)
    }

}