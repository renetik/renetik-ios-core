import UIKit

var delegate: CSApplicationDelegate!
public let logger: CSLoggerProtocol = delegate.logger
public let navigation: CSNavigationController = delegate.navigation

open class CSApplicationDelegate: UIResponder, UIApplicationDelegate {
    public var logger: CSLoggerProtocol!
    public var navigation: CSNavigationController!
    public var window: UIWindow?

    // ViewController orientation change not called, but this yes for landscape left/right
    public let orientationChange = event()

    @discardableResult
    public func onOrientationChange(function: @escaping Func) -> CSRegistration {
        orientationChange.listen(function: function)
    }

    public func application(_ application: UIApplication,
                            _ launchOptions: [UIApplication.LaunchOptionsKey: Any]?,
                            logger: CSLoggerProtocol = NSCSLogger(),
                            navigation: CSNavigationController = CSNavigationController()) {
        delegate = self
        self.logger = logger
        self.navigation = navigation
    }

    public func applicationWillResignActive(_ application: UIApplication) { logInfo(application) }

    public func applicationDidEnterBackground(_ application: UIApplication) { logInfo(application) }

    public func applicationWillEnterForeground(_ application: UIApplication) { logInfo(application) }

    public func applicationDidBecomeActive(_ application: UIApplication) { logInfo(application) }

    public func application(_ application: UIApplication,
                            didChangeStatusBarOrientation oldStatusBarOrientation: UIInterfaceOrientation) {
        orientationChange.fire()
    }

    public func applicationWillTerminate(_ application: UIApplication) { logInfo(application) }
}
