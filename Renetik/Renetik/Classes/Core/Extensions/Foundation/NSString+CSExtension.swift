import Foundation

public extension NSString {
    public static let newLine = "\n"
    public static let notFound = -1

    func index(of string: String, from index: Int) -> Int {
        if index > length - 1 { return NSString.notFound }
        let _range = range(of: string, range: NSRange(location: index, length: length - index))
        if _range.length == 0 { return NSString.notFound }
        return _range.location
    }

    func substring(from: Int, to: Int) -> String {
        let substringLength = to - from
        return substring(with: NSRange(location: from,
                length: substringLength < length ? substringLength : length))
    }

    func trim() -> String { trimmingCharacters(in: .whitespacesAndNewlines) }

    func containsNoCase(_ string: String) -> Boolean {
        range(of: string, options: .caseInsensitive).location != NSNotFound
    }
}