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
    @objc class var width: CGFloat { return UIScreen.width() }
    @objc class var height: CGFloat { return UIScreen.height() }
    @objc class var maxLength: CGFloat { return max(width, height) }
    @objc class var minLength: CGFloat { return min(width, height) }
    @objc class var zoomed: Bool { return UIScreen.main.nativeScale >= UIScreen.main.scale }
    @objc class var retina: Bool { return UIScreen.main.scale >= 2.0 }
    @objc class var phone: Bool { return UIDevice.current.userInterfaceIdiom == .phone }
    @objc class var pad: Bool { return UIDevice.current.userInterfaceIdiom == .pad }
    @objc class var carplay: Bool { return UIDevice.current.userInterfaceIdiom == .carPlay }
    @objc class var tv: Bool { return UIDevice.current.userInterfaceIdiom == .tv }
    class var isSlimScreenLessThenIPhone6: Bool {
        return UIScreen.isPortrait() && (typeIsLike == .iphone4 || typeIsLike == .iphone5)
    }
    @nonobjc class var typeIsLike: DisplayType {
        if phone && maxLength < 568 {
            return .iphone4
        } else if phone && maxLength == 568 {
            return .iphone5
        } else if phone && maxLength == 667 {
            return .iphone6
        } else if phone && maxLength == 736 {
            return .iphone6plus
        } else if pad && !retina {
            return .iPadNonRetina
        } else if pad && retina && maxLength == 1024 {
            return .iPad
        } else if pad && maxLength == 1366 {
            return .iPadProBig
        }
        return .unknown
    }
}
