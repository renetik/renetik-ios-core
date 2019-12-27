//
// Created by Rene Dohan on 12/2/19.
// Copyright (c) 2019 Renetik Software. All rights reserved.
//

import UIKit

public extension UIViewController {
    public func dialog() -> CSAlertController { CSAlertController(in: self) }

    public func dialog(_ message: String) -> CSAlertController {
        CSAlertController(in: self, title: "", message: message)
    }

    public func dialog(_ title: String, _ message: String) -> CSAlertController {
        CSAlertController(in: self, title: title, message: message)
    }
}

public extension UIView {
    public func dialog() -> CSAlertController { navigation.dialog() }

    public func dialog(_ message: String) -> CSAlertController { navigation.dialog(message) }

    public func dialog(_ title: String, _ message: String) -> CSAlertController { navigation.dialog(title, message) }
}

public class CSAlertController: CSObject {

    private let controller: UIViewController
    private var title: String?
    private var message: String?
    private var actions = [(title: String, action: () -> Void)]()
    private var alert: UIAlertController?

    public init(in controller: UIViewController, title: String? = nil, message: String? = nil) {
        self.controller = controller
        self.title = title
        self.message = message
    }

    public func title(_ value: String) -> Self { invoke { title = value } }

    public func message(_ value: String) -> Self { invoke { message = value } }

    public func text(title: String, message: String) -> Self { self.title(title).message(message) }

    public var isVisible: Bool { controller.notNil }

    public func hide() { alert?.dismiss(animated: true) }

    public func add(title: String, action: @escaping () -> Void) -> Self {
        actions.add((title: title, action: action))
        return self
    }

    public func clear() { actions.removeAll() }

    public func showSheetFrom(view: UIView? = nil, item: UIBarButtonItem? = nil) {
        controller.present(createSheet().popoverFrom(view: view, item: item))
    }

    private func createSheet() -> UIAlertController {
        UIAlertController(title: title, message: message, preferredStyle: .actionSheet).also {
            alert = $0
            for action in actions {
                $0.addAction(UIAlertAction(title: action.title, style: .default) { _ in action.action() })
            }
        }
    }

    public func show(withOk okTitle: String = "Ok") {
        alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert!.addAction(UIAlertAction(title: action.title, style: .default) { _ in action.action() })
        }
        alert!.addAction(UIAlertAction(title: okTitle, style: .default) { _ in self.hide() })
        controller.present(alert!, animated: true, completion: nil)
    }

}
