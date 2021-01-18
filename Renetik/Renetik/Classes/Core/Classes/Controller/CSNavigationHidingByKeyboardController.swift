//
//  Renetik
//
//  Created by Rene Dohan on 7/9/19.
//

import RenetikObjc

public class CSNavigationHidingByKeyboardController: CSViewController {

    private var navigationBarHidden = false
    private let keyboardManager = CSKeyboardObserverController()

    @discardableResult
    public override func construct(_ parent: UIViewController) -> Self {
        super.construct(parent).asViewLess()
        keyboardManager.construct(self, onKeyboardChange)
        return self
    }

    private func onKeyboardChange(keyboardHeight: CGFloat) {
        if keyboardHeight > 0 { hideNavigationBar() } else { showNavigationBar() }
    }

    public func hideNavigationBar() {
        if navigationBarHidden { return }
        animate(duration: 0.5) {
            navigation.navigationBar.bottom = UIApplication.statusBarHeight
            navigation.last!.view.margin(top: navigation.navigationBar.bottom)
        }
        navigation.navigationBar.fadeOut(duration: 0.7)
        navigationBarHidden = true
    }

    public func showNavigationBar() {
        if !navigationBarHidden { return }
        animate(duration: 0.5) {
            navigation.navigationBar.top = UIApplication.shared.statusBarFrame.height
            navigation.last!.view.margin(top: navigation.navigationBar.bottom)
        }
        navigation.navigationBar.fadeIn(duration: 0.7)
        navigationBarHidden = false
    }
}
