//
// Created by Rene Dohan on 2/7/20.
//

import Foundation
import UIKit
import MBProgressHUD
import RenetikObjc

public class CSMBDialogController: NSObject, CSHasDialogVisible, MBProgressHUDDelegate {

    public var backgroundColor = UIColor.flatBlack()!.lighten(byPercentage: 0.03)!.add(alpha: 0.7)
    public var foregroundColor = UIColor.white

    private var view: UIView!
    private var hud: MBProgressHUD!

    public func show(in view: UIView, title: String?, message: String, positive: CSDialogAction?,
                     negative: CSDialogAction?, cancel: CSDialogAction?) -> CSHasDialogVisible {
        self.view = view
        MBProgressHUD.hide(for: view, animated: true)
        hud = MBProgressHUD.showAdded(to: view, animated: true).also { hud in
            hud.mode = .text
            hud.removeFromSuperViewOnHide = true
            hud.animationType = .zoom
            hud.contentColor = foregroundColor
            hud.bezelView.style = .solidColor
            hud.bezelView.backgroundColor = backgroundColor
            hud.backgroundView.style = .solidColor
            hud.backgroundView.backgroundColor = .clear
            positive.notNil { action in
                hud.button.text(action.title ?? CSStrings.dialogYes).onClick {
                    action.action()
                    hud.hide(animated: true)
                }
            }
            negative.notNil { action in
                fatalError("Negative not implemented")
            }
            cancel.notNil { onCancel in  //TODO: This is good ?
                hud.onClick {
                    hud.hide(animated: true)
                    onCancel.action()
                }
            }
            hud.detailsLabel.text = "\n" + title.asString
            hud.delegate = self
        }
        return self
    }

    public var isDialogVisible: Bool { hud.notNil }

    public func hideDialog(animated: Bool = true) { hud?.hide(animated: animated) }

     public func hudWasHidden(_ _: MBProgressHUD) {
//        onCancelAction?.action() //TODO: This is good ?
//        onCancelAction = nil
        hud = nil
    }
}
