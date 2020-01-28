//
//  CSHideNavigationBarByScrollingController.swift
//  Renetik
//
//  Created by Rene Dohan on 7/3/19.
//

import RenetikObjc

public protocol CSHasNavigationHiding {
    var navigationHiding: CSNavigationHidingController { get }
}

public class CSNavigationHidingController: CSMainController {
    private var isNavigationBarHidden = false
    private var shouldShow = false
    private var isShowingRunning = false
    private var shouldHide = false
    private var isHidingRunning = false
    private let keyboardManager = CSKeyboardManager()

    public func showIfNotKeyboard() {
        if isNavigationBarHidden && !keyboardManager.isKeyboardVisible { requestNavigationBarShown() }
    }

    @discardableResult
    public func construct(by parent: UIViewController) -> Self {
        super.constructAsViewLess(in: parent)
        keyboardManager.construct(self, onKeyboardChange)
        return self
    }

    private func onKeyboardChange(keyboardHeight: CGFloat) {
        if keyboardHeight > 0 && UIScreen.isLandscape { requestNavigationBarHidden() } else { requestNavigationBarShown() }
    }

    public override func onViewVisibilityChanged(_ visible: Bool) {
        isNavigationBarHidden = navigation.navigationBar.isHidden
    }

    public override func onViewDismissing() {
        super.onViewDismissing()
        requestNavigationBarShown()
    }

    public override func onViewPushedOver() {
        super.onViewPushedOver()
        requestNavigationBarShown()
    }

    public override func onViewWillTransition(toSizeCompletion size: CGSize,
                                              _ context: UIViewControllerTransitionCoordinatorContext) {
        if isNavigationBarHidden { /// TODO: Je totalne dojebany na iphonne x ak otocix skovanyu
            UIView.animate(withDuration: 0.2) {
                navigation.navigationBar.alpha = 0
                navigation.navigationBar.bottom = UIApplication.statusBarHeight()
                navigation.last!.view.height(fromTop: navigation.navigationBar.bottom)
            }
        }
    }

    private var lastContentOffset: CGFloat? = nil

    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastContentOffset = scrollView.contentOffset.y
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isAtTop {
            requestNavigationBarShown()
        } else if scrollView.isAtBottom {
        } else {
            lastContentOffset.notNil { lastOffset in
                if lastOffset < scrollView.contentOffset.y - 50 {
                    requestNavigationBarHidden()
                } else if lastOffset > scrollView.contentOffset.y + 50 {
                    requestNavigationBarShown()
                }
            }
        }
    }

    public func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                         willDecelerate decelerate: Bool) {
        if !decelerate { lastContentOffset = nil }
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        lastContentOffset = nil
    }

    public func requestNavigationBarHidden() {
        if isNavigationBarHidden { return }
        shouldHide = false
        shouldShow = false
        if isShowingRunning {
            shouldHide = true
            return
        }
        hideNavigationBar()
    }

    private func hideNavigationBar() {
        isHidingRunning = true
        isNavigationBarHidden = true
        UIView.animate(withDuration: 0.3, animations: {
            navigation.navigationBar.alpha = 0
            navigation.navigationBar.bottom = UIApplication.statusBarHeight()
            navigation.last!.view.from(top: UIApplication.statusBarHeight())
            navigation.last!.view.height(fromBottom: self.fromBottom)
        }, completion: { _ in
            self.isHidingRunning = false
            if self.shouldShow { self.requestNavigationBarShown() }
        })
    }

    private var fromBottom: CGFloat {
        if navigation.isToolbarHidden { return 0 } else { return navigation.toolbar.topFromBottom }
    }

    public func requestNavigationBarShown() {
        if !isNavigationBarHidden { return }
        shouldShow = false
        shouldHide = false
        if isHidingRunning {
            shouldShow = true
            return
        }
        showNavigationBar()
    }

    private func showNavigationBar() {
        isShowingRunning = true
        isNavigationBarHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            navigation.navigationBar.alpha = 1
            navigation.navigationBar.top = UIApplication.statusBarHeight()
            navigation.last!.view.from(top: navigation.navigationBar.bottom)
            navigation.last!.view.height(fromBottom: self.fromBottom)
        }, completion: { _ in
            self.isShowingRunning = false
            if self.shouldHide { self.requestNavigationBarHidden() }
        })
    }
}
