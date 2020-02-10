//
// Created by Rene Dohan on 2/1/20.
//

import CoreGraphics

public extension CGRect {
    var x: CGFloat { origin.x }
    var y: CGFloat { origin.y }
    var width: CGFloat { size.width }
    var height: CGFloat { size.height }
}