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
        delegate.window?.rootViewController?.get { $0.interfaceOrientation }
                ?? UIApplication.shared.statusBarOrientation
    }
    public class var isPortrait: Bool { orientation.isPortrait }
    public class var isLandscape: Bool { !isPortrait }
    public class var isThin: Bool { isPortrait && UIDevice.isPhone }
    public class var isUltraThin: Bool {
        isPortrait && (UIDevice.typeIsLike == .iphone4 || UIDevice.typeIsLike == .iphone5)
    }
    public class var isWide: Bool { !isThin }
    public class var isUltraWide: Bool { UIDevice.isTablet && isLandscape }
    public class var isShort: Bool { isLandscape && UIDevice.isPhone }
    public class var isUltraShort: Bool {
        isLandscape && (UIDevice.typeIsLike == .iphone4 || UIDevice.typeIsLike == .iphone5)
    }
    public class var isTall: Bool { !isShort }
}
