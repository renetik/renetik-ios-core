//
// Created by Rene Dohan on 1/16/21.
//

import Foundation

public extension NSAttributedString {
    func stringByReplacingOccurrencesOf(string replaceString: String, with image: UIImage, rect: CGRect, tint color: UIColor? = nil) -> NSAttributedString {
        let attributed = mutableCopy() as! NSMutableAttributedString
        var index: Int?
        repeat {
            index = attributed.string.index(of: replaceString,
                    from: index?.get { $0 + replaceString.count } ?? 0)
            index.notNil {
                attributed.replaceCharacters(
                        in: NSRange(location: $0, length: replaceString.count),
                        with: image, rect: rect, tint: color)
            }
        } while index.notNil
        return attributed.copy() as! NSAttributedString
    }
}

public extension NSMutableAttributedString {
    func replaceCharacters(in range: NSRange, with image: UIImage, rect: CGRect, tint color: UIColor? = nil) {
        let textAttachment = NSTextAttachment()
        UIGraphicsBeginImageContextWithOptions(rect.size, false, CGFloat(0.0))
        if color == nil {
            image.draw(in: CGRect(size: rect.size))
        } else {
            color!.set()
            image.template.draw(in: CGRect(size: rect.size))
        }
        textAttachment.image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        textAttachment.bounds = rect
        replaceCharacters(in: range, with: NSAttributedString(attachment: textAttachment))
    }
}