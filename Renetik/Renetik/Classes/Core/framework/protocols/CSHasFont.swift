//
// Created by Rene Dohan on 11/22/20.
//

import Foundation
import UIKit

public protocol CSHasFontProtocol: AnyObject {
    func font() -> UIFont?
    func font(_ font: UIFont?)
}

public extension CSHasFontProtocol {

    var font: UIFont? {
        get { font() }
        set { font(newValue) }
    }

    @discardableResult
    func font(_ font: UIFont) -> Self { self.font = font; return self }

    @discardableResult
    func font(size: CGFloat) -> Self { fontSize = size; return self }

    var fontSize: CGFloat {
        get { font!.fontDescriptor.pointSize }
        set { font = font!.withSize(newValue) }
    }

    @discardableResult
    func font(style: UIFont.TextStyle) -> Self { fontStyle = style; return self }

    var fontStyle: UIFont.TextStyle {
        get { font!.fontDescriptor.object(forKey: .textStyle) as! UIFont.TextStyle }
        set { font = UIFont.preferredFont(forTextStyle: newValue) }
    }

    @discardableResult
    func withBoldFont(if condition: Bool = true) -> Self {
        font = condition ? font?.bold() : font?.normal(); return self
    }
}