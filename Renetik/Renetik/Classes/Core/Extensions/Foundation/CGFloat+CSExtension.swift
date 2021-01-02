//
//  CGFloat+CSExtension.swift
//  Renetik
//
//  Created by Rene Dohan on 4/12/19.
//

import CoreGraphics

public extension CGFloat { //TODO: move to CoreGraphics

    static let margin = CGFloat(8)

    var asUnsigned: CGFloat { self >= 0 ? self : 0 }

    func plus(_ value: Int) -> CGFloat { self + CGFloat(value) }

    func multiply(_ value: Int) -> CGFloat { self * CGFloat(value) }

    static func randomZeroToOne() -> CGFloat { CGFloat(arc4random()) / CGFloat(UInt32.max) }
}
