//
// Created by Rene Dohan on 2/1/21.
//

import Foundation

public extension DateFormatter {
    convenience init(_ format: String) {
        self.init()
        dateFormat = format
    }
}