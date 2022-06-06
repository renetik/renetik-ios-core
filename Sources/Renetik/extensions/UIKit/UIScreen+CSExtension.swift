//
//  UIScreen.swift
//  Renetik
//
//  Created by Rene Dohan on 8/24/19.
//

public extension UIScreen {
    class var size: CGSize { main.bounds.size }
    class var width: CGFloat { size.width }
    class var height: CGFloat { size.height }
    class var maxLength: CGFloat { max(width, height) }
    class var minLength: CGFloat { min(width, height) }
    class var isZoomed: Bool { main.nativeScale >= main.scale }
    class var isRetina: Bool { main.scale >= 2.0 }
    class var orientation: UIInterfaceOrientation {
        Renetik.delegate.window??.windowScene?.interfaceOrientation ?? .unknown
//        UIApplication.shared.delegate?.window??.rootViewController?.interfaceOrientation ??
//            UIApplication.shared.statusBarOrientation
    }
    class var isPortrait: Bool { orientation.isPortrait }
    class var isLandscape: Bool { !isPortrait }
    class var isLandscapeLeft: Bool { orientation == .landscapeLeft }
    class var isLandscapeRight: Bool { orientation == .landscapeRight }
    class var isThin: Bool { isPortrait && UIDevice.isPhone }
    class var isUltraThin: Bool { isPortrait && UIScreen.width <= 375 }
    class var isWide: Bool { !isThin }
    class var isUltraWide: Bool { UIDevice.isTablet && isLandscape }
    class var isShort: Bool { isLandscape && UIDevice.isPhone }
    class var isUltraShort: Bool { isLandscape && isSmallPhone }
    class var isTall: Bool { !isShort } // tablet || portrait
    class var isUltraTall: Bool { UIDevice.isTablet || !isSmallPhone && isPortrait }
    class var isSmallPhone: Bool {
        (UIDevice.typeIsLike == .iphone4 || UIDevice.typeIsLike == .iphone5)
    }
}
