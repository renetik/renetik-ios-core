//
// Created by Rene Dohan on 11/22/20.
//

import Foundation
import UIKit

public protocol CSHasFontProtocol: AnyObject {
    func font() -> UIFont?
    func font(_ font: UIFont?) -> Self
}

extension UIButton: CSHasFontProtocol {
    public func font() -> UIFont? { titleLabel?.font }

    public func font(_ font: UIFont?) -> Self { titleLabel?.font = font; return self }
}

extension UITextView: CSHasFontProtocol {
    public func font() -> UIFont? { font }

    public func font(_ font: UIFont?) -> Self { self.font = font; return self }
}

extension UILabel: CSHasFontProtocol {
    public func font() -> UIFont? { font }

    public func font(_ font: UIFont?) -> Self { self.font = font; return self }
}

public extension CSHasFontProtocol {
    var font: UIFont? {
        get { font() }
        set { font(newValue) }
    }
}