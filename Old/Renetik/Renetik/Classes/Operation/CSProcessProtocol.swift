//
// Created by Rene Dohan on 1/3/20.
//

import Foundation

public protocol CSProcessProtocol: class {
    var message: String? { get }
    var error: Error? { get }
    var failedProcess: CSProcessProtocol? { get }
    func cancel()
    func onSuccess(_ function: @escaping Func) -> Self
    func onFailed(_ function: @escaping Func) -> Self
}
