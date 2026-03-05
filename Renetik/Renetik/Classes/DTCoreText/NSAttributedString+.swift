import UIKit

extension NSAttributedString {
    func withForcedFontSize(_ size: CGFloat) -> NSAttributedString {
        let mutable = NSMutableAttributedString(attributedString: self)
        let fullRange = NSRange(location: 0, length: mutable.length)
        var hasFont = false
        mutable.enumerateAttribute(.font, in: fullRange) { value, range, _ in
            if let current = value as? UIFont {
                hasFont = true
                mutable.addAttribute(.font, value: current.withSize(size), range: range)
            }
        }
        if !hasFont, mutable.length > 0 {
            mutable.addAttribute(.font, value: UIFont.systemFont(ofSize: size), range: fullRange)
        }
        return mutable
    }
}
