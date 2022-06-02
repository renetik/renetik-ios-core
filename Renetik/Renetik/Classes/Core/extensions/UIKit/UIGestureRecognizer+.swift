//
// Created by Rene Dohan on 01/06/22.
//

import UIKit

extension UIGestureRecognizer {
    convenience init(handler: @escaping Func) {
        self.init()
        add(action: handler)
    }

    func add(action: @escaping Func) {
        addTarget(self, action: #selector(handleAction))
        associatedDictionary["action"] = action
    }

    @objc func handleAction(sender: UIBarButtonItem) {
        (associatedDictionary["action"] as? ArgFunc<UIBarButtonItem>)?(sender)
    }
}