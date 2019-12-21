//
//  CSHideNavigationBarByScrollingController.swift
//  Renetik
//
//  Created by Rene Dohan on 7/3/19.
//

import RenetikObjc

public class CSNavigationHidingController: CSMainController {
    var isNavigationBarHidden = false
    var shouldShow = false
    var isShowingRunning = false
    var shouldHide = false
    var isHidingRunning = false
    let keyboardManager = CSKeyboardManager()

    public func showIfNotKeyboard() {
        if isNavigationBarHidden && !keyboardManager.isKeyboardVisible { requestNavigationBarShown() }
    }

    @discardableResult
    public func construct(by parent: UIViewController) -> Self {
        super.constructAsViewLess(in: parent)
        keyboardManager.construct(self, onKeyboardChange)
        return self
    }

    func onKeyboardChange(keyboardHeight: CGFloat) {
        if keyboardHeight > 0 && UIScreen.isLandscape { requestNavigationBarHidden() }
        else { requestNavigationBarShown() }
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
        if isNavigationBarHidden {
            UIView.animate(withDuration: 0.2) {
                navigation.navigationBar.alpha = 0
                navigation.navigationBar.bottom = UIApplication.statusBarHeight()
                navigation.last!.view.height(fromTop: navigation.navigationBar.bottom)
            }
        }
    }

    var lastContentOffset: CGFloat? = nil

    @objc public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastContentOffset = scrollView.contentOffset.y
    }

    @objc public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        lastContentOffset.notNil { lastOffset in
            if scrollView.isAtTop { requestNavigationBarShown() }
            else if scrollView.isAtBottom {}
            else if lastOffset < scrollView.contentOffset.y { requestNavigationBarHidden() }
            else if lastOffset > scrollView.contentOffset.y { requestNavigationBarShown() }
        }
    }

    public func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                         willDecelerate decelerate: Bool) {
        if !decelerate { lastContentOffset = nil }
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        lastContentOffset = nil
    }

    @objc public func requestNavigationBarHidden() {
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

    var fromBottom: CGFloat {
        if navigation.isToolbarHidden { return 0 }
        else { return navigation.toolbar.topFromBottom }
    }

    @objc public func requestNavigationBarShown() {
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
