//
//  UIScreen.swift
//  Renetik
//
//  Created by Rene Dohan on 8/24/19.
//

import Foundation

@objc public extension UIScreen {

    @objc class var portrait: Bool {
        return UIScreen.isPortrait()
    }

    @objc class var landscape: Bool {
        return !portrait
    }

    @objc class var isThin: Bool {
        return portrait && UIDevice.isPhone
    }

    @objc class var isUltraThin: Bool {
        return portrait && (UIDevice.typeIsLike == .iphone4 || UIDevice.typeIsLike == .iphone5)
    }

    @objc class var isWide: Bool {
        return !isThin
    }

    @objc class var isShort: Bool {
        return landscape && UIDevice.isPhone
    }

    @objc class var isUltraShort: Bool {
        return landscape && (UIDevice.typeIsLike == .iphone4 || UIDevice.typeIsLike == .iphone5)
    }

    @objc class var isTall: Bool {
        return !isShort
    }
}
