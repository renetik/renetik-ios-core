//
// Created by Rene Dohan on 1/31/21.
//

import MBProgressHUD

extension MBProgressHUD {
    class func showProgress(view: UIView, title: String, foregroundColor: UIColor,
                            backgroundColor: UIColor, canCancel: Bool,
                            cancelTitle: String?, onCancel: Func?,
                            graceTime: TimeInterval?, minShowTime: TimeInterval?) -> MBProgressHUD {
        MBProgressHUD.hide(for: view, animated: true)
        let hud = MBProgressHUD(view: view)
        view.add(view: hud).matchParent()
        hud.removeFromSuperViewOnHide = true
        graceTime?.then { hud.graceTime = $0 }
        minShowTime?.then { hud.minShowTime = $0 }
        hud.animationType = .zoom
        hud.contentColor = foregroundColor
        hud.bezelView.style = .solidColor
        hud.bezelView.backgroundColor = .clear
        hud.backgroundView.style = .solidColor
        hud.backgroundView.backgroundColor = backgroundColor
        if canCancel {
            hud.detailsLabel.text = title.isSet ? "\n" + title + "\n" : "\n"
            hud.button.text(cancelTitle ?? .cs_dialog_cancel).onClick {
                onCancel?()
                hud.hide(animated: true)
            }
        } else {
            hud.detailsLabel.text = "\n" + title.asString
        }
        hud.show(animated: true)
        return hud
    }
}