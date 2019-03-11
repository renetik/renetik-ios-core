////
////  UIDevice+CSExtension.swift
////  Renetik
////
////  Created by Rene Dohan on 3/10/19.
////
//
//import UIKit
//
//@objc public extension UIDevice {
//    @objc public static var isPortrait: Bool {
//        return UIDevice.current.orientation.isValidInterfaceOrientation
//            ? UIDevice.current.orientation.isPortrait
//            : UIApplication.shared.statusBarOrientation.isPortrait
//    }
//
//    @objc public class var isLandscape: Bool {
//        return !isPortrait
//    }
//
//    @objc public class var iPhone: Bool {
//        return UIDevice.current.userInterfaceIdiom == .phone
//    }
//
//    @objc public class var iPad: Bool {
//        return UIDevice.current.userInterfaceIdiom == .pad
//    }
//
//    @objc public class var isWideScreen: Bool {
//        return isWideScreenIOS8
//    }
//
//    @objc public class var isWideScreenIOS8: Bool {
//        return Float(fabs(UIScreen.main.nativeBounds.size.height - 1136)) < Float(DBL_EPSILON)
//    }
//
//    @objc public class var systemVersionNumber: Double {
//        return Double(UIDevice.current.systemVersion)!
//    }
//
//    @objc public class var isIOS10: Bool {
//        return systemVersionNumber >= 10
//    }
//
//    @objc public class var isIOS11: Bool {
//        return systemVersionNumber >= 11
//    }
//}
