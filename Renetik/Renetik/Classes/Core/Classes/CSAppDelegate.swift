//
//  CSAppDelegate.swift
//  BlocksKit
//
//  Created by Rene Dohan on 2/9/19.
//

import RenetikObjc

var logger: CSLogger = delegate.logger
var navigation: UINavigationController = delegate.navigation
var delegate: CSAppDelegate = CSAppDelegate.instance()

@objc open class CSAppDelegate: UIResponder, UIApplicationDelegate {
    @objc public var logger: CSLogger!
    @objc public var navigation: UINavigationController!
    @objc public var window: UIWindow?
    public func setup(_ logger: CSLogger, _ navigation: UINavigationController) {
        self.logger = logger
        self.navigation = navigation
    }
}

@objc public extension CSAppDelegate {
    @objc public class func instance() -> CSAppDelegate {
        return UIApplication.shared.delegate as! CSAppDelegate
    }
}
