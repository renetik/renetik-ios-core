//
//  UIScreen.swift
//  Renetik
//
//  Created by Rene Dohan on 8/24/19.
//

import Foundation
import UIKit

public extension UIScreen {
    public class var size: CGSize { main.bounds.size }
    public class var width: CGFloat { size.width }
    public class var height: CGFloat { size.height }
    public class var maxLength: CGFloat { max(width, height) }
    public class var minLength: CGFloat { min(width, height) }
    public class var isZoomed: Bool { main.nativeScale >= main.scale }
    public class var isRetina: Bool { main.scale >= 2.0 }
    public class var orientation: UIInterfaceOrientation {
        UIApplication.shared.delegate?.window??.rootViewController?.interfaceOrientation ??
            UIApplication.shared.statusBarOrientation
    }
    public class var isPortrait: Bool { orientation.isPortrait }
    public class var isLandscape: Bool { !isPortrait }
    public class var isLandscapeLeft: Bool { orientation == .landscapeLeft }
    public class var isLandscapeRight: Bool { orientation == .landscapeRight }
    public class var isThin: Bool { isPortrait && UIDevice.isPhone }
    public class var isUltraThin: Bool { isPortrait && UIScreen.width <= 375 }
    public class var isWide: Bool { !isThin }
    public class var isUltraWide: Bool { UIDevice.isTablet && isLandscape }
    public class var isShort: Bool { isLandscape && UIDevice.isPhone }
    public class var isUltraShort: Bool { isLandscape && isSmallPhone }
    public class var isTall: Bool { !isShort } // tablet || portrait
    public class var isUltraTall: Bool { UIDevice.isTablet || !isSmallPhone && isPortrait }
    public class var isSmallPhone: Bool {
        (UIDevice.typeIsLike == .iphone4 || UIDevice.typeIsLike == .iphone5)
    }
}
