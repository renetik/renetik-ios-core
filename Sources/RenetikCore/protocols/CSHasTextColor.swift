//
// Created by Rene Dohan on 11/22/20.
//

import Foundation
import UIKit

public protocol CSHasTextColorProtocol: AnyObject {
    func textColor() -> UIColor?
    @discardableResult
    func text(color: UIColor?) -> Self
}

extension UITextView: CSHasTextColorProtocol {
    public func textColor() -> UIColor? { textColor }

    @discardableResult
    public func text(color: UIColor?) -> Self { textColor = color; return self }
}

extension UILabel: CSHasTextColorProtocol {
    public func textColor() -> UIColor? { textColor }

    @discardableResult
    public func text(color: UIColor?) -> Self { textColor = color; return self }
}

public extension CSHasTextColorProtocol {
    var textColor: UIColor? {
        get { textColor() }
        set { text(color: newValue) }
    }
}