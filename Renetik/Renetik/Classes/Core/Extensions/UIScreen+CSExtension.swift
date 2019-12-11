//
//  UIScreen.swift
//  Renetik
//
//  Created by Rene Dohan on 8/24/19.
//

import Foundation

@objc public extension UIScreen {

    @nonobjc public class var isPortrait: Bool {
        UIScreen.isPortrait()
    }

    @nonobjc public class var isLandscape: Bool {
        !isPortrait
    }

    public class var isThin: Bool {
        isPortrait && UIDevice.isPhone
    }

    public class var isUltraThin: Bool {
        isPortrait && (UIDevice.typeIsLike == .iphone4 || UIDevice.typeIsLike == .iphone5)
    }

    public class var isWide: Bool {
        !isThin
    }

    public class var isUltraWide: Bool {
        UIDevice.isTablet && isLandscape
    }

    public class var isShort: Bool {
        isLandscape && UIDevice.isPhone
    }

    public class var isUltraShort: Bool {
        isLandscape && (UIDevice.typeIsLike == .iphone4 || UIDevice.typeIsLike == .iphone5)
    }

    public class var isTall: Bool {
        !isShort
    }

    @nonobjc public class var width: CGFloat {
        UIScreen.width()
    }

    @nonobjc public class var height: CGFloat {
        UIScreen.height()
    }
}
