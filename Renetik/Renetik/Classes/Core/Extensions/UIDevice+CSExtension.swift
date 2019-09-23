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

    @objc class var width: CGFloat {
        return UIScreen.width()
    }
    @objc class var height: CGFloat {
        return UIScreen.height()
    }
    @objc class var maxLength: CGFloat {
        return max(width, height)
    }
    @objc class var minLength: CGFloat {
        return min(width, height)
    }
    @objc class var isZoomed: Bool {
        return UIScreen.main.nativeScale >= UIScreen.main.scale
    }
    @objc class var isRetina: Bool {
        return UIScreen.main.scale >= 2.0
    }
    @objc class var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    @objc class var isTablet: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    @objc class var isCarplay: Bool {
        return UIDevice.current.userInterfaceIdiom == .carPlay
    }
    @objc class var isTV: Bool {
        return UIDevice.current.userInterfaceIdiom == .tv
    }
    @nonobjc class var typeIsLike: DisplayType {
        if isPhone && maxLength < 568 {
            return .iphone4
        } else if isPhone && maxLength == 568 {
            return .iphone5
        } else if isPhone && maxLength == 667 {
            return .iphone6
        } else if isPhone && maxLength == 736 {
            return .iphone6plus
        } else if isTablet && !isRetina {
            return .iPadNonRetina
        } else if isTablet && isRetina && maxLength == 1024 {
            return .iPad
        } else if isTablet && maxLength == 1366 {
            return .iPadProBig
        }
        return .unknown
    }
}
