//
// Created by Rene Dohan on 2/1/20.
//

import Foundation
import CoreGraphics

public extension CGRect {

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
    
//    var width: CGFloat {
//        get { size.width }
//        set { size.width = newValue }
//    }
    
    @discardableResult
    mutating func width(_ value:CGFloat) -> Self { size.width = value; return self }
    
//    var height: CGFloat {
//        get { size.height }
//        set { size.height = newValue }
//    }
    
    @discardableResult
    mutating func height(_ value:CGFloat) -> Self { size.height = value; return self }
}
