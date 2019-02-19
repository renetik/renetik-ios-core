//
// Created by Rene Dohan on 2019-01-21.
//

import Foundation

public extension NSString {
    @objc public static let newLine = "\n"
    @objc public static let notFound = -1

    @objc func indexOf(_ string: String, from index: Int) -> Int {
        let _range = range(of: string, range: NSRange(location: index, length: length - index))
        if _range.length == 0 { return NSString.notFound }
        return _range.location
    }

    @objc func substring(from: Int, to: Int) -> NSString {
        return substring(with: NSRange(location: from, length: to - from)) as NSString
    }
}
