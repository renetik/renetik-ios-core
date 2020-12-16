//
// Created by Rene Dohan on 1/11/20.
//

import Foundation

public protocol CSInputFilterProtocol {
    func filter(current: String, range: NSRange, string: String) -> Bool
}

public class CSIntMaxValueInputFilter: CSInputFilterProtocol {
    let getMaxValue: () -> Int

    public init(_  getMaxValue: @escaping () -> Int) {
        self.getMaxValue = getMaxValue
    }

    public func filter(current: String, range: NSRange, string: String) -> Bool {
        let newString = current.replace(range: range, with: string)
        return newString.asInt <= getMaxValue()
    }
}

public class CSIntMaxLengthInputFilter: CSInputFilterProtocol {
    let maxLength: Int

    public init(_  maxLength: Int) {
        self.maxLength = maxLength
    }

    public func filter(current: String, range: NSRange, string: String) -> Bool {
        current.length < maxLength
    }
}