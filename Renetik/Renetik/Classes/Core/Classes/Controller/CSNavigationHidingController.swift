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
            _ parent: UIViewController) -> Self {
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

    public override func onViewPushedOver() {
        super.onViewPushedOver()
        showNavigationBar()
    }

    public override func onViewWillTransition(toSizeCompletion
                                              size: CGSize, _ context: UIViewControllerTransitionCoordinatorContext) {
        if isNavigationBarHidden {
            UIView.animate(withDuration: 0.2, animations: {
                navigation.navigationBar.bottom = UIApplication.statusBarHeight()
                navigation.last!.view.top(toHeight: navigation.navigationBar.bottom)
            })
        }
    }

    var lastContentOffset: CGFloat = 0

    @objc public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastContentOffset = scrollView.contentOffset.y
    }

    @objc public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if kayboardManager.isKeyboardVisible { return }
        if scrollView.isAtTop {
            showNavigationBar()
        } else if scrollView.isAtBottom {
        } else if lastContentOffset < scrollView.contentOffset.y {
            hideNavigationBar()
        } else if lastContentOffset > scrollView.contentOffset.y {
            showNavigationBar()
        }
    }

    @objc public func hideNavigationBar() {
        if isNavigationBarHidden { return }
        isNavigationBarHidden = true
        UIView.animate(withDuration: 0.3, animations: {
            navigation.navigationBar.bottom = UIApplication.statusBarHeight()
            if navigation.last!.view.superview != nil {
                navigation.last!.view.top(UIApplication.statusBarHeight())
                navigation.last!.view.fromBottom(toHeight: self.fromBottom)
            }
        })
        navigation.navigationBar.fadeOut(0.45)
    }

    var fromBottom: CGFloat {
        if navigation.isToolbarHidden { return 0 } else { return navigation.toolbar.topFromBottom }
    }

    @objc public func showNavigationBar() {
        if !isNavigationBarHidden { return }
        isNavigationBarHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            navigation.navigationBar.top = UIApplication.statusBarHeight()
            if navigation.last!.view.superview != nil {
                navigation.last!.view.top(navigation.navigationBar.bottom)
                navigation.last!.view.fromBottom(toHeight: self.fromBottom)
            }
        })
        navigation.navigationBar.fade(in: 0.45)
    }
}
