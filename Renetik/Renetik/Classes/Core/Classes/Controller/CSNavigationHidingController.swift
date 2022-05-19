//
//  CSHideNavigationBarByScrollingController.swift
//  Renetik
//
//  Created by Rene Dohan on 7/3/19.
//

import UIKit

//TODO:  Make standalone library !!!
public class CSNavigationHidingController: CSViewController {
    private var isNavigationBarHidden = false
    private var shouldShow = false
    private var isShowingRunning = false
    private var shouldHide = false
    private var isHidingRunning = false
    private let keyboardManager = CSKeyboardObserverController()

    public func showIfNotKeyboard() {
        if isNavigationBarHidden && !keyboardManager.isKeyboardVisible { requestNavigationBarShown() }
    }

    @discardableResult
    public func construct(by parent: UIViewController) -> Self {
        super.construct(parent).asViewLess()
        keyboardManager.construct(self, onKeyboardChange)
        return self
    }

    private func onKeyboardChange(keyboardHeight: CGFloat) {
        if !isAppearing { return }
        if keyboardHeight > 0 && UIScreen.isLandscape {
            requestNavigationBarHidden()
        } else {
            requestNavigationBarShown()
        }
    }

    public override func onViewVisibilityChanged(_ visible: Bool) {
        isNavigationBarHidden = navigation.navigationBar.isHidden
    }

    public override func onViewDismissing() {
        super.onViewDismissing()
        requestNavigationBarShown(animated: false)
    }

    public override func onViewPushedOver() {
        super.onViewPushedOver()
        requestNavigationBarShown(animated: false)
    }

    public override func onViewDidTransition(to _: CGSize, _ _: UIViewControllerTransitionCoordinatorContext) {
        requestNavigationBarShown()
    }

    private var lastDraggingContentOffset: CGFloat? = nil

    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastDraggingContentOffset = scrollView.contentOffset.y
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isAtTop {
            requestNavigationBarShown()
        } else if scrollView.isAtBottom {
        } else {
            if lastDraggingContentOffset.isNil { return }
            if lastDraggingContentOffset! < scrollView.contentOffset.y - 400 {
                requestNavigationBarHidden()
            } else if lastDraggingContentOffset! > scrollView.contentOffset.y + 200 {
                requestNavigationBarShown()
            }
        }
    }

    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate { lastDraggingContentOffset = nil }
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        lastDraggingContentOffset = nil
    }

    public func requestNavigationBarHidden() {
        if UIScreen.isUltraTall { return }
        lastDraggingContentOffset = nil
        if isNavigationBarHidden { return }
        shouldHide = false
        shouldShow = false
        if isShowingRunning {
            shouldHide = true
            return
        }
        hideNavigationBar()
    }

    private func hideNavigationBar(animated: Bool = true) {
        isHidingRunning = true
        isNavigationBarHidden = true
        invoke(animated: animated, operation: {
            navigation.navigationBar.bottom = UIApplication.statusBarBottom
            self.parentController!.view.margin(top: navigation.navigationBar.bottom)
        }, completion: {
            navigation.navigationBar.hide()
            self.isHidingRunning = false
            if self.shouldShow { self.requestNavigationBarShown() }
        })
    }

    public func requestNavigationBarShown(animated: Bool = true) {
        lastDraggingContentOffset = nil
        if !isNavigationBarHidden { return }
        shouldShow = false
        shouldHide = false
        if isHidingRunning {
            shouldShow = true
            return
        }
        showNavigationBar(animated: animated)
    }

    private func showNavigationBar(animated: Bool = true) {
        isShowingRunning = true
        isNavigationBarHidden = false
        navigation.navigationBar.show()
        invoke(animated: animated, operation: {
            navigation.navigationBar.top = UIApplication.statusBarBottom
            self.parentController!.view.margin(top: navigation.navigationBar.bottom)
        }, completion: {
            self.isShowingRunning = false
            if self.shouldHide { self.requestNavigationBarHidden() }
        })
    }
}
