@_exported import Foundation
@_exported import UIKit

public class Renetik {
    public static var delegate: UIApplicationDelegate { UIApplication.shared.delegate! }
    public static var navigation: UINavigationController?
    
    public class func initialize(_ logger: CSLoggerProtocol = NSCSLogger(),
                                 _ navigation: UINavigationController? = nil) {
        CSLogger.initialize(logger)
        Renetik.navigation = navigation
    }
    
    public class func test() {
        
    }
}
