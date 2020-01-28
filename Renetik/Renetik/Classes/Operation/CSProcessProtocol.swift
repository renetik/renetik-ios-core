//
// Created by Rene Dohan on 1/3/20.
//

import Foundation

public protocol CSProcessProtocol {
    var message: String? { get }
    var error: Error? { get }
    func cancel()
}
