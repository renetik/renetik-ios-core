//
//  UIScreen.swift
//  Renetik
//
//  Created by Rene Dohan on 8/24/19.
//

import Foundation

@objc public extension UIScreen {

//    public class var portrait: Bool {
//        return UIScreen.isPortrait()
//    }

    @nonobjc public class var isPortrait: Bool {
        return UIScreen.isPortrait()
    }

//    public class var landscape: Bool {
//        return !isPortrait
//    }

    @nonobjc public class var isLandscape: Bool {
        return !isPortrait
    }

    public class var isThin: Bool {
        return isPortrait && UIDevice.isPhone
    }

    public class var isUltraThin: Bool {
        return isPortrait && (UIDevice.typeIsLike == .iphone4 || UIDevice.typeIsLike == .iphone5)
    }

    public class var isWide: Bool {
        return !isThin
    }

    public class var isUltraWide: Bool {
        return UIDevice.isTablet && isLandscape
    }

    public class var isShort: Bool {
        return isLandscape && UIDevice.isPhone
    }

    public class var isUltraShort: Bool {
        return isLandscape && (UIDevice.typeIsLike == .iphone4 || UIDevice.typeIsLike == .iphone5)
    }

    public class var isTall: Bool {
        return !isShort
    }

    @nonobjc public class var width: CGFloat {
        return UIScreen.width()
    }

    @nonobjc public class var height: CGFloat {
        return UIScreen.height()
    }
}
