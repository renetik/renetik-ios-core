//
// Created by Rene Dohan on 12/26/19.
//

import Foundation

public protocol CSHasLabelProtocol {
    func label() -> String?
    func label(_ text: String?)
}

public extension CSHasLabelProtocol {
    @discardableResult
    func label(_ text: String?) -> Self { self.label(text); return self }

    @discardableResult
    func label(text: String?) -> Self { self.label(text) }

    public var labelValue: String {
        get { label() ?? "" }
        set { label(newValue) }
    }

    var label: String? {
        get { label() }
        set { label(newValue) }
    }

    @discardableResult
    public func label(prepend: String) -> Self { label("\(prepend)\(labelValue)") }

    @discardableResult
    public func label(append: String) -> Self { label("\(labelValue)\(append)") }

    @discardableResult
    public func label(replace: String, with: String) -> Self {
        self.label(labelValue.replace(all: replace, with: with))
    }
}

public extension CSHasLabelProtocol where Self: UIView {
    static func construct(label: String) -> Self { construct().label(text: label) }
}