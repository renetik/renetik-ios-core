//
// Created by Rene Dohan on 2/1/20.
//

import Foundation
import UIKit
import CoreGraphics

public extension CGSize {

    init(size: Int) {
        self.init(size: CGFloat(size))
    }

    init(size: CGFloat) {
        self.init(width: size, height: size)
    }
}
