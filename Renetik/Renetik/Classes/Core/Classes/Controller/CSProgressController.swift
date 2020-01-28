//
// Created by Rene Dohan on 1/11/20.
//

import Foundation
import MBProgressHUD
import ChameleonFramework

public class CSProgressController: CSObject, CSHasProgress, CSHasDialogVisible {

    public var backgroundColor = UIColor.flatBlack()!.lighten(byPercentage: 0.03)!.add(alpha: 0.7)
    public var foregroundColor = UIColor.white
    private let controller: UIViewController
    private var hud: MBProgressHUD?

    public init(in controller: UIViewController) {
        self.controller = controller
    }

    public var isVisible: Bool { hud.notNil }

    public func hide(animated: Bool = true) { hud?.hide(animated: animated) }

    public func show(progress title: String, cancel: CSDialogAction?) -> CSHasDialogVisible {
        MBProgressHUD.hide(for: controller.view, animated: true)
        hud = MBProgressHUD.showAdded(to: controller.view, animated: true).also { hud in
            hud.removeFromSuperViewOnHide = true
            hud.animationType = .zoom
            hud.contentColor = foregroundColor
            hud.bezelView.style = .solidColor
            hud.bezelView.backgroundColor = backgroundColor
            hud.dimBackground = true

            cancel.notNil { cancel in
                hud.detailsLabel.text = title.isSet ? "\n" + title + "\n" : "\n"
                hud.button.title(cancel.title ?? CSStrings.dialogCancel).onClick {
                    cancel.action()
                    hud.hide(animated: true)
                }
            }.elseDo {
                hud.detailsLabel.text = "\n" + title.asString
            }
            hud.activityIndicatorColor = foregroundColor
        }
        return self
    }
}
