//
// Created by Rene Dohan on 2/1/20.
//

import CoreGraphics

public extension CGSize {

    static let defaultViewSize = CGSize(width: UIScreen.width, height: UIScreen.height)

    init(size: Int) {
        self.init(size: CGFloat(size))
    }

    init(size: CGFloat) {
        self.init(width: size, height: size)
    }
}