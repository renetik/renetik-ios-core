//
// Created by Rene on 2018-11-22.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

import Foundation

public extension Collection {
    public var hasItems: Bool { !isEmpty }
    public var length: Int { count }
    public var size: Int { count }
    public var lastIndex: Int { length - 1 }
}