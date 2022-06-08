//
// Created by Rene Dohan on 01/06/22.
//

import UIKit

extension UIGestureRecognizer {
    convenience init(handler: @escaping ArgFunc<UIGestureRecognizer>) {
        self.init()
        add(action: handler)
    }

    func add(action: @escaping ArgFunc<UIGestureRecognizer>) {
        addTarget(self, action: #selector(handleAction))
        associatedDictionary["action"] = action
    }

    @objc func handleAction(sender: UIGestureRecognizer) {
        (associatedDictionary["action"] as? ArgFunc<UIGestureRecognizer>)?(sender)
    }
}