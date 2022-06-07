//
// Created by Rene Dohan on 30/05/22.
//

import Foundation

open class CSHasTitleBase: CSAnyProtocol, Equatable, CSHasTitle, CustomStringConvertible {
    public let title: String

    public init(_ title: String) { self.title = title }

    public var description: String { title }
}