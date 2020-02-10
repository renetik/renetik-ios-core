//
//  UILabel+CSExtension.swift
//  Renetik
//
//  Created by Rene Dohan on 3/6/19.
//

import UIKit

@objc public extension UILabel {
    @discardableResult
    @objc public func withBoldFont(_ isBold: Bool = true) -> Self {
        if isBold { font = font.bold() } else { font = font.normal() }
        return self
    }
}
