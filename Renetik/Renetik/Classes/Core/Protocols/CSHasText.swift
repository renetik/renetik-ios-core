//
// Created by Rene Dohan on 12/26/19.
//

import Foundation

public protocol CSHasTextProtocol: class {
    var text: String? { get set }
}

public extension CSHasTextProtocol {
    @discardableResult
    func text(_ text: String?) -> Self {
        self.text = text
        return self
    }
}