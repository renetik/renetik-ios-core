//
//  CSNavigationByKeyboardHidingController.swift
//  Renetik
//
//  Created by Rene Dohan on 7/9/19.
//

import RenetikObjc

@objc public class CSNavigationByKeyboardHidingController: CSChildViewLessController {
    var navigationBarHidden = false
    lazy var kayboardManager: CSKeyboardManager = {
        CSKeyboardManager().construct(self)
    }()

    @discardableResult
    @objc public override func construct(
        _ parent: CSMainController) -> Self {
        super.construct(parent)
        kayboardManager.onKayboardChange = onKayboardChange
        return self
    }

    func onKayboardChange(kayboardHeight: CGFloat) {
        if kayboardHeight > 0 {
            hideNavigationBar()
        } else {
            showNavigationBar()
        }
    }

    @objc public func hideNavigationBar() {
        if navigationBarHidden { return }
        UIView.animate(0.5) {
            navigation.navigationBar.bottom = UIApplication.statusBarHeight()
            navigation.last!.view.top(toHeight: navigation.navigationBar.bottom)
        }
        navigation.navigationBar.fadeOut(0.7)
        navigationBarHidden = true
    }

    @objc public func showNavigationBar() {
        if !navigationBarHidden { return }
        UIView.animate(0.5) {
            navigation.navigationBar.top = UIApplication.shared.statusBarFrame.height
            navigation.last!.view.top(toHeight: navigation.navigationBar.bottom)
        }
        navigation.navigationBar.fade(in: 0.7)
        navigationBarHidden = false
    }
}
