//
// Created by Rene Dohan on 11/22/20.
//

import Foundation
import UIKit

public protocol CSHasTextColorProtocol: AnyObject {
    func textColor() -> UIColor?
    func text(color: UIColor?) -> Self
}

extension UIButton: CSHasTextColorProtocol {
    public func textColor() -> UIColor? { titleColor(for: .normal) }

    public func text(color: UIColor?) -> Self { setTitleColor(color, for: .normal); return self }
}

extension UITextView: CSHasTextColorProtocol {
    public func textColor() -> UIColor? { textColor }

    public func text(color: UIColor?) -> Self { textColor = color; return self }
}

extension UILabel: CSHasTextColorProtocol {
    public func textColor() -> UIColor? { textColor }

    public func text(color: UIColor?) -> Self { textColor = color; return self }
}

public extension CSHasTextColorProtocol {
    var textColor: UIColor? {
        get { textColor() }
        set { text(color: newValue) }
    }
}