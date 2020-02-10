//
// Created by Rene Dohan on 12/22/19.
//

import Foundation
import UIKit
import RenetikObjc

public protocol CSResponseController {
    func show<T: AnyObject>(_ response: CSResponse<T>, _ progress: Bool, _ canCancel: Bool,
                            _ failedDialog: Bool, _ onSuccess: ((T) -> Void)?) -> CSResponse<T>
}

public extension CSResponseController {
    @discardableResult
    public func show<Data: AnyObject>(_ response: CSResponse<Data>,
                                      progress: Bool = true, canCancel: Bool = true,
                                      failedDialog: Bool = true,
                                      onSuccess: ((Data) -> Void)? = nil) -> CSResponse<Data> {
        show(response, progress, canCancel, failedDialog, onSuccess)
    }
}