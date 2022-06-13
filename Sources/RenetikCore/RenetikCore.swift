@_exported import Foundation
@_exported import UIKit

public class RenetikCore {
    public static var delegate: UIApplicationDelegate { UIApplication.shared.delegate! }

    public class func initialize(logger: CSLoggerProtocol = NSCSLogger()) {
        CSLogger.initialize(logger)
    }

}
