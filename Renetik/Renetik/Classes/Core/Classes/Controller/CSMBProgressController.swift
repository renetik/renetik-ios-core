//
// Created by Rene Dohan on 1/11/20.
//

import Foundation
import MBProgressHUD
import ChameleonFramework

public class CSMBProgressController: CSObject, CSHasProgressProtocol, CSHasDialogVisible {

    public var backgroundColor = UIColor.flatBlack()!.lighten(byPercentage: 0.03)!.add(alpha: 0.85)
    public var foregroundColor = UIColor.white
    private unowned let view: UIView
    private var hud: MBProgressHUD?

    public init(in controller: UIViewController) {
        view = controller.view
    }

    public init(in view: UIView) {
        self.view = view
    }

    public var isDialogVisible: Bool { hud.notNil }

    public func hideDialog(animated: Bool = true) { hud?.hide(animated: animated) }

    public func show(progress title: String, _ cancel: CSDialogAction?,
                     _ graceTime: TimeInterval?, _ minShowTime: TimeInterval?) -> CSHasDialogVisible {
        hud = MBProgressHUD.showProgress(view: view, title: title,
                foregroundColor: foregroundColor, backgroundColor: backgroundColor,
                canCancel: cancel.notNil, cancelTitle: cancel?.title, onCancel: cancel?.action,
                graceTime: graceTime, minShowTime: minShowTime)
        hud!.completionBlock = { [weak self] in self?.hud = nil }
        return self
    }
}
