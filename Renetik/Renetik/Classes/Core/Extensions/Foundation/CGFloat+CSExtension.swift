//
//  CGFloat+CSExtension.swift
//  Renetik
//
//  Created by Rene Dohan on 4/12/19.
//

import Foundation

public extension CGFloat {
	public func plus(_ value: Int) -> CGFloat {
		return self + CGFloat(value)
	}

	public func multiply(_ value: Int) -> CGFloat {
		return self * CGFloat(value)
	}
}
