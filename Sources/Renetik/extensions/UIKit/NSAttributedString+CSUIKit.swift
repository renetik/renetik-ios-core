//
// Created by Rene Dohan on 1/16/21.
//

import Foundation
import UIKit

public extension NSAttributedString {
    func stringByReplacingOccurrencesOf(string replaceString: String, with image: UIImage, rect: CGRect, tint color: UIColor? = nil) -> NSAttributedString {
        let attributed = mutableCopy() as! NSMutableAttributedString
        var index: Int?
        repeat {
            index = attributed.string.index(of: replaceString,
                    from: index?.ret { $0 + replaceString.count } ?? 0)
            index.notNil {
                attributed.replaceCharacters(
                        in: NSRange(location: $0, length: replaceString.count),
                        with: image, rect: rect, tint: color)
            }
        } while index.notNil
        return attributed.copy() as! NSAttributedString
    }
}
