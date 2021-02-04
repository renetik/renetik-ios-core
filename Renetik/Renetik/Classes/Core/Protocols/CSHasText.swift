//
// Created by Rene Dohan on 12/26/19.
//

import Foundation

public protocol CSHasTextProtocol: class {
    func text() -> String?
    func text(_ text: String?)
}

public extension CSHasTextProtocol {
    @discardableResult
    func text(_ text: String?) -> Self { self.text = text; return self }

    public var title: String {
        get { text() ?? "" }
        set { text(newValue) }
    }

    var text: String? {
        get { text() }
        set { text(newValue) }
    }

    @discardableResult
    public func text(prepend: String) -> Self { text("\(prepend)\(title)") }

    @discardableResult
    public func text(append: String) -> Self { text("\(title)\(append)") }

    @discardableResult
    public func text(replace: String, with: String) -> Self { self.text(title.replace(all: replace, with: with)) }
}

public extension CSHasTextProtocol where Self: UIView {
    @discardableResult
    func hideIfEmpty() -> Self { self.isVisible = text?.trim().isSet == true; return self }
}