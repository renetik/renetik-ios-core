//
//  Renetik
//
//  Created by Rene Dohan on 7/9/19.
//

import RenetikObjc

public class CSNavigationHidingByKeyboardController: CSMainController {

    var navigationBarHidden = false
    let keyboardManager = CSKeyboardManager()

    @discardableResult
    public func construct(_ parent: UIViewController) -> Self {
        super.constructAsViewLess(in: parent)
        keyboardManager.construct(self, onKeyboardChange)
        return self
    }

    func onKeyboardChange(keyboardHeight: CGFloat) {
        if keyboardHeight > 0 {
            hideNavigationBar()
        }
        else {
            showNavigationBar()
        }
    }

    public func hideNavigationBar() {
        if navigationBarHidden { return }
        UIView.animate(0.5) {
            navigation.navigationBar.bottom = UIApplication.statusBarHeight()
            navigation.last!.view.height(fromTop: navigation.navigationBar.bottom)
        }
        navigation.navigationBar.fadeOut(0.7)
        navigationBarHidden = true
    }

    public func showNavigationBar() {
        if !navigationBarHidden { return }
        UIView.animate(0.5) {
            navigation.navigationBar.top = UIApplication.shared.statusBarFrame.height
            navigation.last!.view.height(fromTop: navigation.navigationBar.bottom)
        }
        navigation.navigationBar.fade(in: 0.7)
        navigationBarHidden = false
    }
}
