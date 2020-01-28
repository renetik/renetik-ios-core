//
//  Integer+CSExtension.swift
//  Renetik
//
//  Created by Rene Dohan on 5/7/19.
//

import Foundation

public extension Int {
    public var isEmpty: Bool { self == 0 }
    public var isSet: Bool { !isEmpty }
    public var set: Bool { isSet }
}
