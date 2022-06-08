//
// Created by Rene Dohan on 1/29/20.
//

import UIKit

public extension UIView {

    var width: CGFloat {
        get { frame.size.width }
        set {
            var frame = frame
            frame.size.width = newValue
            self.frame = frame
        }
    }

    @discardableResult
    @objc func width(_ value: CGFloat) -> Self { width = value; return self }

    @discardableResult
    func width(as view: UIView) -> Self { width(view.width) }

    var height: CGFloat {
        get { frame.size.height }
        set {
            var frame = frame
            frame.size.height = newValue
            self.frame = frame
        }
    }

    @discardableResult
    func height(_ value: CGFloat) -> Self { self.height = value; return self }
}
