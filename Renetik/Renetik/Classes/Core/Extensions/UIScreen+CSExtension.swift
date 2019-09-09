//
//  UIScreen.swift
//  Renetik
//
//  Created by Rene Dohan on 8/24/19.
//

import Foundation

@objc public extension UIScreen {

    @objc public class var portrait: Bool {
        return UIScreen.isPortrait()
    }

    @objc public class var landscape: Bool {
        return !portrait
    }

    @objc public class var isThin: Bool {
        return portrait && UIDevice.isPhone
    }

    @objc public class var isUltraThin: Bool {
        return portrait && (UIDevice.typeIsLike == .iphone4 || UIDevice.typeIsLike == .iphone5)
    }

    @objc public class var isWide: Bool {
        return !isThin
    }

    @objc public class var isUltraWide: Bool {
        return UIDevice.isTablet && landscape
    }

    @objc public class var isShort: Bool {
        return landscape && UIDevice.isPhone
    }

    @objc public class var isUltraShort: Bool {
        return landscape && (UIDevice.typeIsLike == .iphone4 || UIDevice.typeIsLike == .iphone5)
    }

    @objc public class var isTall: Bool {
        return !isShort
    }

    @nonobjc public class var width: CGFloat {
        return UIScreen.width()
    }

    @nonobjc public class var height: CGFloat {
        return UIScreen.height()
    }
}
