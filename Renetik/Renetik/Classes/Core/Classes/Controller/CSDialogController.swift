//
// Created by Rene Dohan on 12/2/19.
// Copyright (c) 2019 Renetik Software. All rights reserved.
//

import UIKit
import MBProgressHUD
import ChameleonFramework
import RenetikObjc

public protocol CSDialogProtocol {
    func title(_ value: String) -> Self
    func message(_ value: String) -> Self
    func text(title: String, message: String) -> Self
    var isVisible: Bool { get }
    func hide()
    func add(title: String, action: @escaping () -> Void) -> Self
    func clear()
    func showSheetFrom(view: UIView?, item: UIBarButtonItem?)
    func show(positiveTitle: String, positiveAction: @escaping () -> Void,
              negativeTitle: String, negativeAction: @escaping () -> Void)
    func show(withOk okTitle: String)
    func showProgress(cancelTitle: String?, onCancel: ((CSDialogController) -> Void)?) -> Self
}

public extension CSDialogProtocol {
    func showSheetFrom(view: UIView) { showSheetFrom(view: view, item: nil) }

    func showSheetFrom(item: UIBarButtonItem) { showSheetFrom(view: nil, item: item) }

    func show() { show(withOk: "Ok") }

    func showProgress(onCancel: @escaping ((CSDialogController) -> Void)) -> Self {
        showProgress(cancelTitle: nil, onCancel: onCancel)
    }
}

public protocol CSHasDialogController where Self: UIViewController {
    func dialog() -> CSDialogProtocol
    func dialog(_ message: String) -> CSDialogProtocol
    func dialog(_ title: String, _ message: String) -> CSDialogProtocol
}

extension UIViewController: CSHasDialogController {
    public func dialog() -> CSDialogProtocol {
        CSDialogController(in: self)
    }

    public func dialog(_ message: String) -> CSDialogProtocol {
        CSDialogController(in: self, message: message)
    }

    public func dialog(_ title: String, _ message: String) -> CSDialogProtocol {
        CSDialogController(in: self, title: title, message: message)
    }
}

public class CSDialogController: CSObject, CSDialogProtocol {

    private let controller: UIViewController
    private var title: String?
    private var message: String?
    private var actions = [(title: String, action: () -> Void)]()
    private var alert: UIAlertController?
    private var mbProgressHud: MBProgressHUD?

    public init(in controller: UIViewController, title: String? = nil, message: String? = nil) {
        self.controller = controller
        self.title = title
        self.message = message
    }

    public func title(_ value: String) -> Self { invoke { title = value } }

    public func message(_ value: String) -> Self { invoke { message = value } }

    public func text(title: String, message: String) -> Self { self.title(title).message(message) }

    public var isVisible: Bool { controller.notNil }

    public func hide() {
        alert?.dismiss(animated: true)
        mbProgressHud?.hide(animated: true)
    }

    public func add(title: String, action: @escaping () -> Void) -> Self {
        actions.add((title: title, action: action))
        return self
    }

    public func clear() { actions.removeAll() }

    public func showSheetFrom(view: UIView?, item: UIBarButtonItem?) {
        UIAlertController(title: title, message: message, preferredStyle: .actionSheet).also { alert in
            for action in actions {
                alert.addAction(UIAlertAction(title: action.title,
                        style: .default) { _ in action.action() })
            }
            present(alert.popoverFrom(view: view, item: item))
        }
    }

    public func show(positiveTitle: String, positiveAction: @escaping () -> Void,
                     negativeTitle: String, negativeAction: @escaping () -> Void) {
        UIAlertController(title: title, message: message, preferredStyle: .alert).also { alert in
            alert.addAction(UIAlertAction(title: positiveTitle,
                    style: .default) { _ in positiveAction() })
            alert.addAction(UIAlertAction(title: negativeTitle,
                    style: .destructive) { _ in negativeAction() })
            present(alert)
        }
    }

    public func show(withOk okTitle: String) {
        UIAlertController(title: title, message: message, preferredStyle: .alert).also { alert in
            for action in actions {
                alert.addAction(UIAlertAction(title: action.title,
                        style: .default) { _ in action.action() })
            }
            alert.addAction(UIAlertAction(title: okTitle, style: .default) { _ in self.hide() })
            present(alert)
        }
    }

    public func showProgress(cancelTitle: String?,
                             onCancel: ((CSDialogController) -> Void)?) -> Self {
        MBProgressHUD.hide(for: controller.view, animated: true)
        mbProgressHud = MBProgressHUD.showAdded(to: controller.view, animated: true).also { hud in
            hud.removeFromSuperViewOnHide = true
            hud.animationType = .zoom
            hud.contentColor = .white
            hud.bezelView.style = .solidColor
            hud.bezelView.backgroundColor =
                    UIColor.flatBlack()!.lighten(byPercentage: 0.03)!.add(alpha: 0.87)
            let title = self.title.isSet ? self.title! : message
            onCancel.notNil { cancel in
                hud.detailsLabel.text = title.isSet ? "\n" + title! + "\n" : "\n"
                hud.button.title(cancelTitle ?? CSStrings.dialogCancel).onClick { _ in
                    onCancel?(self)
                    self.mbProgressHud?.hide(animated: true)
                }
//                hud.button.titleLabel!.fontStyle(.headline)
//                hud.button.titleLabel?.textColor = .white
//                hud.button.show()
            }.elseDo {
                hud.detailsLabel.text = "\n" + title.asString
            }
            hud.detailsLabel.textColor = .white

//            let indicator = UIActivityIndicatorView.cast(hud.bezelView.subviews[5])
//            hud.tintColor = .white
//            hud.color = .white
        }
        return self
    }

    private func present(_ alert: UIAlertController) {
        self.alert = alert
        controller.present(alert, animated: true, completion: nil)
    }
}