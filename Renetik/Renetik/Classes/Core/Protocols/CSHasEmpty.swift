//
// Created by Rene Dohan on 2/5/21.
//

import Foundation

public protocol CSHasEmptyProtocol {
    var isEmpty: Bool { get }
}

public extension CSHasEmptyProtocol {
    var isSet: Bool { !isEmpty }
}