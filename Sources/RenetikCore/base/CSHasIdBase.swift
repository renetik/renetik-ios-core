//
// Created by Rene Dohan on 29/05/22.
//

import Foundation

open class CSHasIdBase: CSAnyProtocol, Equatable, CSHasId, CustomStringConvertible {
    public let id: String

    public init(_ id: String) { self.id = id }

    public var description: String { id }
}