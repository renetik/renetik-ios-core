//
//  UILabel+CSExtension.swift
//  Renetik
//
//  Created by Rene Dohan on 3/6/19.
//

import UIKit

@objc public extension UILabel {
    @discardableResult
    public func withBoldFont(if condition: Bool = true) -> Self {
        font = condition ? font.bold() : font.normal()
        return self
    }
}
