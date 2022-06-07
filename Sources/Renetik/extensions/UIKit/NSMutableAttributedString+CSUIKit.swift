//
// Created by Rene Dohan on 1/16/21.
//

import UIKit

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
