//
// Created by Rene Dohan on 12/22/19.
//

import Foundation
import UIKit
import RenetikObjc

public protocol CSResponseControllerProtocol where Self: UIViewController {
    func show<T: AnyObject>(progress response: CSResponse<T>) -> CSResponse<T>
    func show<T: AnyObject>(failed response: CSResponse<T>) -> CSResponse<T>
}

public extension CSResponseControllerProtocol {
    public func show<T: AnyObject>(_ response: CSResponse<T>) -> CSResponse<T> {
        show(progress: response)
        show(failed: response)
        return response
    }
}