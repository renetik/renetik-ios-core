//
// Created by Rene Dohan on 12/26/19.
//

import Foundation
import UIKit

public protocol CSHasTextProtocol: AnyObject {
    func text() -> String?
    func text(_ text: String?)
}

public extension CSHasTextProtocol {
    @discardableResult
    func text(_ text: String?) -> Self { self.text(text); return self }

    var textValue: String {
        get { text() ?? "" }
        set { text(newValue) }
    }

    var text: String? {
        get { text() }
        set { text(newValue) }
    }

    @discardableResult
    func text(prepend: String) -> Self { text("\(prepend)\(textValue)") }

    @discardableResult
    func text(append: String) -> Self { text("\(textValue)\(append)") }

    @discardableResult
    func text(replace: String, with: String) -> Self { self.text(textValue.replace(all: replace, with: with)) }
}

public extension CSHasTextProtocol where Self: UIView {
    @discardableResult
    func hideIfEmpty() -> Self { self.isVisible = text?.trim().isSet == true; return self }
}

extension CSHasEmptyProtocol where Self: CSHasTextProtocol {
    var isEmpty: Bool { textValue.trim().isEmpty }
}
