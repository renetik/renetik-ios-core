import RenetikObjc

public class CSNavigationHidingController: CSMainController {
    private let keyboardManager = CSKeyboardManager()

    public func showIfNotKeyboard() {
        if !keyboardManager.isKeyboardVisible { requestNavigationBarShown() }
    }

    @discardableResult
    public func construct(by parent: UIViewController) -> Self {
        super.constructAsViewLess(in: parent)
        keyboardManager.construct(self, onKeyboardChange)
        enable()
        return self
    }

    private func onKeyboardChange(keyboardHeight: CGFloat) {
        if !isAppearing { return }
        enable()
        if canHideNavigationBar, keyboardHeight > 0, UIScreen.isLandscape {
            requestNavigationBarHidden()
        } else {
            requestNavigationBarShown()
        }
    }

    override public func onViewWillAppear() {
        super.onViewWillAppear()
        enable()
    }

    override public func onViewVisibilityChanged(_ visible: Bool) {
        if visible {
            enable()
        } else {
            requestNavigationBarShown(animated: false)
        }
    }

    override public func onViewDismissing() {
        super.onViewDismissing()
        requestNavigationBarShown(animated: false)
    }

    override public func onViewPushedOver() {
        super.onViewPushedOver()
        requestNavigationBarShown(animated: false)
    }

    override public func onViewDidTransition(to _: CGSize, _ _: UIViewControllerTransitionCoordinatorContext) {
        requestNavigationBarShown()
        enable()
    }

    private var canHideNavigationBar: Bool {
        !UIDevice.isTablet
    }

    public func enable() {
        navigation.hidesBarsOnSwipe = canHideNavigationBar
        navigation.hidesBarsWhenKeyboardAppears = canHideNavigationBar && UIScreen.isLandscape
    }

    public func scrollViewWillBeginDragging(_: UIScrollView) {}

    public func scrollViewDidScroll(_: UIScrollView) {}

    public func scrollViewDidEndDragging(_: UIScrollView, willDecelerate _: Bool) {}

    public func scrollViewDidEndDecelerating(_: UIScrollView) {}

    public func requestNavigationBarHidden(animated: Bool = true) {
        if !canHideNavigationBar { return }
        navigation.setNavigationBarHidden(true, animated: animated)
    }

    public func requestNavigationBarShown(animated: Bool = true) {
        navigation.setNavigationBarHidden(false, animated: animated)
    }
}
