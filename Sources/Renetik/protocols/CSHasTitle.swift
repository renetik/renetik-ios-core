//
// Created by Rene Dohan on 29/05/22.
//

import Foundation

public protocol CSHasTitle {
    var title: String { get }
}

public extension CustomStringConvertible where Self: CSHasTitle {
    var description: String { title }
}