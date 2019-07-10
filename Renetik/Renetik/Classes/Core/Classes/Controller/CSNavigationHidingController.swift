//
//  CSHideNavigationBarByScrollingController.swift
//  Renetik
//
//  Created by Rene Dohan on 7/3/19.
//

import RenetikObjc

@objc public class CSNavigationHidingController: CSChildViewLessController {
    var isNavigationBarHidden = false
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

    public func showIfNotKeyboard() {
        if isNavigationBarHidden && !kayboardManager.isKeyboardVisible {
            showNavigationBar()
        }
    }

    func onKayboardChange(kayboardHeight: CGFloat) {
        if kayboardHeight > 0 {
            hideNavigationBar()
        } else {
            showNavigationBar()
        }
    }

    public override func onViewVisibilityChanged(_ visible: Bool) {
        isNavigationBarHidden = navigation.navigationBar.isHidden
    }

    public override func onViewDismissing() {
        super.onViewDismissing()
        showNavigationBar()
    }

    public override func onViewWillTransition(toSizeCompletion size: CGSize, _ context: UIViewControllerTransitionCoordinatorContext) {
        if isNavigationBarHidden {
            UIView.animate(0.3) {
                navigation.navigationBar.bottom = UIApplication.statusBarHeight()
                navigation.last!.view.top(toHeight: navigation.navigationBar.bottom)
            }
        }
    }

    @objc public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if kayboardManager.isKeyboardVisible { return }
		
        if scrollView.isAtTop {
            showNavigationBar()
        } else if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            hideNavigationBar()
        } else {
            showNavigationBar()
        }
    }

    @objc public func hideNavigationBar() {
        if isNavigationBarHidden { return }
        UIView.animate(0.5) {
            navigation.navigationBar.bottom = UIApplication.statusBarHeight()
            navigation.last!.view.top(toHeight: navigation.navigationBar.bottom)
        }
        navigation.navigationBar.fadeOut(0.7)
        isNavigationBarHidden = true
    }

    @objc public func showNavigationBar() {
        if !isNavigationBarHidden { return }
        UIView.animate(0.5) {
            navigation.navigationBar.top = UIApplication.shared.statusBarFrame.height
            navigation.last!.view.top(toHeight: navigation.navigationBar.bottom)
        }
        navigation.navigationBar.fade(in: 0.7)
        isNavigationBarHidden = false
    }
}
