//
// Created by Rene Dohan on 2/1/20.
//

import Foundation
import CoreGraphics

public extension CGRect {
    static let defaultViewRect = CGRect(origin: .zero, size: .defaultViewSize)

    init(size: CGFloat) {
        self.init(width: size, height: size)
    }

    init(size: CGSize) {
        self.init(width: size.width, height: size.height)
    }

    init(width: CGFloat, height: CGFloat) {
        self.init(origin: .zero, size: CGSize(width: width, height: height))
    }

    var x: CGFloat { origin.x }
    var y: CGFloat { origin.y }
    var width: CGFloat {
        get { size.width }
        set { size.width = newValue }
    }
    var height: CGFloat {
        get { size.height }
        set { size.height = newValue }
    }

}
