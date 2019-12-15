public enum DisplayType {
    case unknown
    case iphone4
    case iphone5
    case iphone6
    case iphone6plus
    case iPadNonRetina
    case iPad
    case iPadProBig
    static let iphone7 = iphone6
    static let iphone7plus = iphone6plus
}

@objc public extension UIDevice {

    public class func set(orientation: UIInterfaceOrientation) {
        UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
    }

    class var width: CGFloat { UIScreen.width() }
    class var height: CGFloat { UIScreen.height() }
    class var maxLength: CGFloat { max(width, height) }
    class var minLength: CGFloat { min(width, height) }
    class var isZoomed: Bool { UIScreen.main.nativeScale >= UIScreen.main.scale }
    class var isRetina: Bool { UIScreen.main.scale >= 2.0 }
    class var isPhone: Bool { UIDevice.current.userInterfaceIdiom == .phone }
    class var isTablet: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    class var isCarplay: Bool { UIDevice.current.userInterfaceIdiom == .carPlay }
    class var isTV: Bool { UIDevice.current.userInterfaceIdiom == .tv }

    @nonobjc class var typeIsLike: DisplayType {
        if isPhone && maxLength < 568 {
            return .iphone4
        }
        else if isPhone && maxLength == 568 {
            return .iphone5
        }
        else if isPhone && maxLength == 667 {
            return .iphone6
        }
        else if isPhone && maxLength == 736 {
            return .iphone6plus
        }
        else if isTablet && !isRetina {
            return .iPadNonRetina
        }
        else if isTablet && isRetina && maxLength == 1024 {
            return .iPad
        }
        else if isTablet && maxLength == 1366 {
            return .iPadProBig
        }
        return .unknown
    }
}
