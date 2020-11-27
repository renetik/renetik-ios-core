//
//  CSAppDelegate.swift
//  BlocksKit
//
//  Created by Rene Dohan on 2/9/19.
//

import RenetikObjc

public let delegate: CSApplicationDelegate = CSApplicationDelegate.instance
public let logger: CSLoggerProtocol = delegate.logger
public let navigation: CSNavigationController = delegate.navigation

open class CSApplicationDelegate: UIResponder, UIApplicationDelegate {
    public var logger: CSLoggerProtocol!
    public var navigation: CSNavigationController!
    public var window: UIWindow?

    public func setup(logger: CSLoggerProtocol, navigation: CSNavigationController) {
        self.logger = logger
        self.navigation = navigation
    }
}