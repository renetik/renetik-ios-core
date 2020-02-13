//
// Created by Rene Dohan on 2/12/20.
//

import CoreGraphics

public extension CGPoint {
    func distance(from point: CGPoint) -> CGFloat {
        ((x - point.x) * (x - point.x) + (y - point.y) * (y - point.y)).squareRoot()
    }

    var left: CGFloat { x }

    var top: CGFloat { y }
}