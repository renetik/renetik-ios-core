//
//  CSHideNavigationBarByScrollingController.swift
//  Renetik
//
//  Created by Rene Dohan on 7/3/19.
//

import RenetikObjc

//TODO:  Make standalone library
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
        requestNavigationBarShown(animated: false)
    }

    public override func onViewPushedOver() {
        super.onViewPushedOver()
        requestNavigationBarShown(animated: false)
    }

    public override func onViewWillTransition(toSizeCompletion size: CGSize,
                                              _ context: UIViewControllerTransitionCoordinatorContext) {
//        if isNavigationBarHidden { /// TODO: Je totalne dojebany na iphonne x ak otocix skovanyu
//            UIView.animate(withDuration: 0.2) {
//                navigation.navigationBar.alpha = 0
//                navigation.navigationBar.bottom = UIApplication.statusBarHeight()
//                navigation.last!.view.height(fromTop: navigation.navigationBar.bottom)
//            }
//        }
    }

    private var lastDraggingContentOffset: CGFloat? = nil

    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastDraggingContentOffset = scrollView.contentOffset.y
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if lastDraggingContentOffset.isNil { return }
        if scrollView.isAtTop {
            requestNavigationBarShown()
        } else if scrollView.isAtBottom {
        } else {
            if lastDraggingContentOffset! < scrollView.contentOffset.y - 400 {
                requestNavigationBarHidden()
            } else if lastDraggingContentOffset! > scrollView.contentOffset.y + 400 {
                requestNavigationBarShown()
            }
        }
    }

    public func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                         willDecelerate decelerate: Bool) {
        if !decelerate { lastDraggingContentOffset = nil }
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        lastDraggingContentOffset = nil
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

    private func hideNavigationBar(animated: Bool = true) {
        isHidingRunning = true
        isNavigationBarHidden = true
        invoke(animated: animated, duration: 0.3, operation: {
            navigation.navigationBar.alpha = 0
            navigation.navigationBar.bottom = UIApplication.statusBarHeight()
            navigation.last!.view.height(fromTop: navigation.navigationBar.bottom)
        }, completion: {
            navigation.navigationBar.isHidden = true
            self.isHidingRunning = false
            if self.shouldShow { self.requestNavigationBarShown() }
        })
    }

    private var fromBottom: CGFloat {
        if navigation.isToolbarHidden { return 0 } else { return navigation.toolbar.topFromBottom }
    }

    public func requestNavigationBarShown(animated: Bool = true) {
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
        invoke(animated: animated, duration: 0.3, operation: {
            navigation.navigationBar.isHidden = false
            navigation.navigationBar.alpha = 1

//            navigation.navigationBar.top = UIApplication.statusBarHeight()
//            navigation.last!.view.from(top: navigation.navigationBar.bottom)
//            navigation.last!.view.height(fromBottom: self.fromBottom)

            navigation.navigationBar.top = UIApplication.shared.statusBarFrame.height
            navigation.last!.view.height(fromTop: navigation.navigationBar.bottom)
        }, completion: {
            self.isShowingRunning = false
            if self.shouldHide { self.requestNavigationBarHidden() }
        })
    }
}
