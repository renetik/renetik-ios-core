//
// Created by Rene Dohan on 12/1/20.
//

import Foundation

public protocol CSJsonObjectProtocol {
    var asDictionary: [String: Any?] { get }
}

public protocol CSJsonArrayProtocol {
    var asArray: [Any?] { get }
}