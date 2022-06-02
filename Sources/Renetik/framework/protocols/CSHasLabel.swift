//
// Created by Rene Dohan on 12/26/19.
//

import Foundation
import UIKit

public protocol CSHasLabelProtocol {
    func label() -> String?
    func label(_ text: String?)
}

public extension CSHasLabelProtocol {
    @discardableResult
    func label(_ text: String?) -> Self { self.label(text); return self }

    @discardableResult
    func label(text: String?) -> Self { self.label(text) }

    var labelValue: String {
        get { label() ?? "" }
        set { label(newValue) }
    }

    var label: String? {
        get { label() }
        set { label(newValue) }
    }

    @discardableResult
    func label(prepend: String) -> Self { label("\(prepend)\(labelValue)") }

    @discardableResult
    func label(append: String) -> Self { label("\(labelValue)\(append)") }

    @discardableResult
    func label(replace: String, with: String) -> Self {
        self.label(labelValue.replace(all: replace, with: with))
    }
}

public extension CSHasLabelProtocol where Self: UIView {
    static func construct(label: String) -> Self { construct().label(text: label) }
}
