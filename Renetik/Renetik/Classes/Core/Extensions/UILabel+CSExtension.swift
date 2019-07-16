//
//  UILabel+CSExtension.swift
//  Renetik
//
//  Created by Rene Dohan on 3/6/19.
//

import UIKit

@objc public extension UILabel {
    @discardableResult
    @objc public func withBoldFont(_ isBold: Bool) -> Self {
        if isBold { font = font.bold() } else { font = font.normal() }
        return self
    }

    @discardableResult
    @objc public func sizeHeightToFit(characters count: Int) -> Self {
        let previousString = text
        text = String.randomString(length: count)
        sizeHeightToFit()
        text = previousString
        return self
    }
}
