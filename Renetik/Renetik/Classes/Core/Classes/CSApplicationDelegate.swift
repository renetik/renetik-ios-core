//
//  CSAppDelegate.swift
//  BlocksKit
//
//  Created by Rene Dohan on 2/9/19.
//

import RenetikObjc

public var logger: CSLogger = delegate.logger
public var navigation: CSNavigationController = delegate.navigation
public var delegate: CSApplicationDelegate = CSApplicationDelegate.instance()

open class CSApplicationDelegate: UIResponder, UIApplicationDelegate {
    @objc public var logger: CSLogger!
    @objc public var navigation: CSNavigationController!
    @objc public var window: UIWindow?

    public func setup(logger: CSLogger, navigation: CSNavigationController) {
        self.logger = logger
        self.navigation = navigation
    }
}

@objc public extension CSApplicationDelegate {
    public class func instance() -> CSApplicationDelegate {
        UIApplication.shared.delegate as! CSApplicationDelegate
    }
}
