//
//  Created by Rene Dohan on 5/7/19.
//

import Foundation
import CoreGraphics

public extension Int {
    var isEmpty: Bool { self == 0 }
    var isSet: Bool { !isEmpty }
    var set: Bool { isSet }
    var asFloat: CGFloat { CGFloat(self) }

    func until(_ end: Int) -> CountableRange<Int> { self <= end ? self..<end : self..<self }

    func until(_ end: Int, _ function: (Int) -> Void) { for index in 0.until(end) { function(index) } }

    func `in`(range: ClosedRange<Int>) -> Bool { range.contains(self) }
}
