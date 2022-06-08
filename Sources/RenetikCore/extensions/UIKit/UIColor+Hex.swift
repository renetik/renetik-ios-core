#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit

public typealias HexColor = UIColor
#else
import Cocoa

public typealias HexColor = NSColor
#endif

public extension HexColor {

    convenience init?(_ hex: String, alpha: CGFloat? = nil) {
        guard let hexType = Type(from: hex), let components = hexType.components() else {
            return nil
        }
        #if os(iOS) || os(watchOS) || os(tvOS)
        self.init(red: components.red, green: components.green, blue: components.blue, alpha: alpha ?? components.alpha)
        #else
        self.init(calibratedRed: components.red, green: components.green, blue: components.blue, alpha: alpha ?? components.alpha)
        #endif
    }

//    class func hexColor(hex: String, alpha: CGFloat = CGFloat(1.0)) -> UIColor {
//        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
//        if (cString.hasPrefix("#")) { cString.remove(at: cString.startIndex) }
//        if (cString.count != 6) { return UIColor.gray }
//        var rgbValue: UInt64 = 0
//        Scanner(string: cString).scanHexInt64(&rgbValue)
//        return UIColor(
//            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
//            alpha: alpha
//        )
//    }

    var hex: String {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0, rgb: Int
        getRed(&r, green: &g, blue: &b, alpha: &a)

        if a == 1 { // no alpha value set, we are returning the short version
            rgb = (Int)(r * 255) << 16 | (Int)(g * 255) << 8 | (Int)(b * 255) << 0
            return String(format: "#%06x", rgb)
        }
        else {
            rgb = (Int)(r * 255) << 24 | (Int)(g * 255) << 16 | (Int)(b * 255) << 8 | (Int)(a * 255) << 0
            return String(format: "#%08x", rgb)
        }
    }

    private enum `Type` {
        case RGBshort(rgb: String)
        case RGBshortAlpha(rgba: String)
        case RGB(rgb: String)
        case RGBA(rgba: String)

        init?(from hex: String) {
            var hexString = hex
            hexString.removeHashIfNecessary()
            guard let t = Type.transform(hex: hexString) else { return nil }
            self = t
        }

        static func transform(hex string: String) -> Type? {
            switch string.count {
            case 3: return .RGBshort(rgb: string)
            case 4: return .RGBshortAlpha(rgba: string)
            case 6: return .RGB(rgb: string)
            case 8: return .RGBA(rgba: string)
            default: return nil
            }
        }

        var value: String {
            switch self {
            case .RGBshort(let rgb): return rgb
            case .RGBshortAlpha(let rgba): return rgba
            case .RGB(let rgb): return rgb
            case .RGBA(let rgba): return rgba
            }
        }

        typealias rgbComponents = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)

        func components() -> rgbComponents? {
            var hexValue: UInt64 = 0
            guard Scanner(string: value).scanHexInt64(&hexValue) else { return nil }
            let r, g, b, a, divisor: CGFloat
            switch self {
            case .RGBshort(_):
                divisor = 15
                r = CGFloat((hexValue & 0xF00) >> 8) / divisor
                g = CGFloat((hexValue & 0x0F0) >> 4) / divisor
                b = CGFloat(hexValue & 0x00F) / divisor
                a = 1
            case .RGBshortAlpha(_):
                divisor = 15
                r = CGFloat((hexValue & 0xF000) >> 12) / divisor
                g = CGFloat((hexValue & 0x0F00) >> 8) / divisor
                b = CGFloat((hexValue & 0x00F0) >> 4) / divisor
                a = CGFloat(hexValue & 0x000F) / divisor
            case .RGB(_):
                divisor = 255
                r = CGFloat((hexValue & 0xFF0000) >> 16) / divisor
                g = CGFloat((hexValue & 0x00FF00) >> 8) / divisor
                b = CGFloat(hexValue & 0x0000FF) / divisor
                a = 1
            case .RGBA(_):
                divisor = 255
                r = CGFloat((hexValue & 0xFF000000) >> 24) / divisor
                g = CGFloat((hexValue & 0x00FF0000) >> 16) / divisor
                b = CGFloat((hexValue & 0x0000FF00) >> 8) / divisor
                a = CGFloat(hexValue & 0x000000FF) / divisor
            }
            return (red: r, green: g, blue: b, alpha: a)
        }
    }
}

private extension String {
    mutating func removeHashIfNecessary() {
        if hasPrefix("#") { self = replacingOccurrences(of: "#", with: "") }
    }
}