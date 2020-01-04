//
// Created by Rene Dohan on 1/3/20.
//

import Foundation

public protocol CSDialogControllerProtocol where Self: UIViewController {
    func show(title: String?, message: String,
              positiveTitle: String?, onPositive: (() -> Void)?,
              negativeTitle: String?, onNegative: (() -> Void)?,
              onCanceled: (() -> Void)?)
}

public extension CSDialogControllerProtocol {
    public func show(message: String, onPositive: (() -> Void)? = nil) {
        show(title: nil, message: message,
                positiveTitle: nil, onPositive: onPositive,
                negativeTitle: nil, onNegative: nil,
                onCanceled: nil)
    }

    public func show(message: String, positiveTitle: String, onPositive: (() -> Void)? = nil) {
        show(title: nil, message: message,
                positiveTitle: positiveTitle, onPositive: onPositive,
                negativeTitle: nil, onNegative: nil,
                onCanceled: nil)
    }
}