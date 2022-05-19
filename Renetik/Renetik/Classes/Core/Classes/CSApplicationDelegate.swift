//
//  CSAppDelegate.swift
//  BlocksKit
//
//  Created by Rene Dohan on 2/9/19.
//

import Foundation
import UIKit

public let delegate: CSApplicationDelegate = CSApplicationDelegate.instance
public let logger: CSLoggerProtocol = delegate.logger
public let navigation: CSNavigationController = delegate.navigation

open class CSApplicationDelegate: UIResponder, UIApplicationDelegate {
    public var logger: CSLoggerProtocol!
    public var navigation: CSNavigationController!
    public var window: UIWindow?

//    public func setup(logger: CSLoggerProtocol = NSCSLogger(toast: false),
//                      navigation: CSNavigationController = CSNavigationController()) {
//        self.logger = logger
//        self.navigation = navigation
//    }

    public func application(_ application: UIApplication,
                            _ launchOptions: [UIApplication.LaunchOptionsKey: Any]?,
                            logger: CSLoggerProtocol = NSCSLogger(),
                            navigation: CSNavigationController = CSNavigationController()) {
        self.logger = logger
        self.navigation = navigation
    }

    public func applicationWillResignActive(_ application: UIApplication) { logInfo(application) }

    public func applicationDidEnterBackground(_ application: UIApplication) { logInfo(application) }

    public func applicationWillEnterForeground(_ application: UIApplication) { logInfo(application) }

    public func applicationDidBecomeActive(_ application: UIApplication) { logInfo(application) }

    public func applicationWillTerminate(_ application: UIApplication) { logInfo(application) }
}