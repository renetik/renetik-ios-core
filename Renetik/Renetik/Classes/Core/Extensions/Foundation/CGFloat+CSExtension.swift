//
//  CGFloat+CSExtension.swift
//  Renetik
//
//  Created by Rene Dohan on 4/12/19.
//

import CoreGraphics

public extension CGFloat { //TODO: move to CoreGraphics
    public func plus(_ value: Int) -> CGFloat { self + CGFloat(value) }

    public func multiply(_ value: Int) -> CGFloat { self * CGFloat(value) }

    public var unsigned: CGFloat { self >= 0 ? self : 0 }
}
