@_exported import Foundation
@_exported import UIKit

public class RenetikCore {
    public class func initialize(logger: CSLoggerProtocol) {
        CSLogger.initialize(logger)
    }
}
