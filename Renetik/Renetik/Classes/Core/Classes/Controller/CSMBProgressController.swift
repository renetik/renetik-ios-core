//
// Created by Rene Dohan on 1/11/20.
//

import Foundation
import MBProgressHUD
import ChameleonFramework

public class CSMBProgressController: CSObject, CSHasProgressProtocol, CSHasDialogVisible {

    public var backgroundColor = UIColor.flatBlack()!.lighten(byPercentage: 0.03)!.add(alpha: 0.85)
    public var foregroundColor = UIColor.white
    private let view: UIView
    private var hud: MBProgressHUD?

    public init(in controller: UIViewController) {
        view = controller.view
    }

    public init(in view: UIView) {
        self.view = view
    }

    public var isDialogVisible: Bool { hud.notNil }

    public func hideDialog(animated: Bool = true) { hud?.hide(animated: animated) }

    public func show(progress title: String, cancel: CSDialogAction?) -> CSHasDialogVisible {
        MBProgressHUD.hide(for: view, animated: true)
        hud = MBProgressHUD(view: view).also { hud in
            view.add(view: hud)
            hud.removeFromSuperViewOnHide = true
            hud.graceTime = 1
            hud.minShowTime = 2
            hud.animationType = .zoom
            hud.contentColor = foregroundColor
            hud.bezelView.style = .solidColor
            hud.bezelView.backgroundColor = .clear
            hud.backgroundView.style = .solidColor
            hud.backgroundView.backgroundColor = backgroundColor
            cancel.notNil { cancel in
                hud.detailsLabel.text = title.isSet ? "\n" + title + "\n" : "\n"
                hud.button.text(cancel.title ?? .cs_dialog_cancel).onClick {
                    cancel.action()
                    hud.hide(animated: true)
                }
            }.elseDo {
                hud.detailsLabel.text = "\n" + title.asString
            }
            hud.completionBlock = { self.hud = nil }
            hud.show(animated: true)
        }
        return self
    }
}
