//
//  UIViewController+CSExtension.swift
//  Renetik
//
//  Created by Rene Dohan on 2/19/19.
//

import RenetikObjc
import UIKit

@objc public extension UIViewController {
    @discardableResult
    @objc public func push() -> Self {
        navigation.push(self)
        return self
    }

    @discardableResult
    @objc public func pushFromTop() -> Self {
        navigation.push(fromTop: self)
        return self
    }
}

