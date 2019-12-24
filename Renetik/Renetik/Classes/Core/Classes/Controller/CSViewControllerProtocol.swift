//
// Created by Rene Dohan on 12/22/19.
//

import Foundation
import UIKit
import RenetikObjc

public protocol CSViewControllerProtocol {
    func asController() -> UIViewController
    func show<T: AnyObject>(_ response: CSResponse<T>) -> CSResponse<T>
    func showProgress<T: AnyObject>(_ response: CSResponse<T>) -> CSResponse<T>
    func showFailed<T: AnyObject>(_ response: CSResponse<T>) -> CSResponse<T>
    func show(message: String, onPositive: (() -> Void)?)
    func show(title: String?, message: String, positiveTitle: String,
              onPositive: @escaping () -> Void, negativeTitle: String, onCanceled: (() -> Void)?)
}

public extension CSViewControllerProtocol {

    public func show(message: String) { show(message: message, onPositive: nil) }

    public func show(message: String, positiveTitle: String,
                     onPositive: @escaping () -> Void, negativeTitle: String) {
        show(title: nil, message: message, positiveTitle: positiveTitle,
                onPositive: onPositive, negativeTitle: negativeTitle, onCanceled: nil)
    }

    public func show(message: String, positiveTitle: String,
                     onPositive: @escaping () -> Void, negativeTitle: String,
                     onCanceled: @escaping () -> Void) {
        show(title: nil, message: message, positiveTitle: positiveTitle,
                onPositive: onPositive, negativeTitle: negativeTitle, onCanceled: onCanceled)
    }
}