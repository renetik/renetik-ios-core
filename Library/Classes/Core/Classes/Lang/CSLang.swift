//
// Created by Rene on 2018-11-22.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

import Foundation

public let YES = true
public let NO = false

public protocol CSLang {
}

public extension CSLang {

    public var notNil: Bool {
        return true
    }

    public var isNil: Bool {
        return false
    }

    public func apply(_ function: (Self) -> Void) -> Self {
        function(self)
        return self
    }

    public func then(function: (Self) -> Void) {
        function(self)
    }

    public func get<ReturnType>(function: (Self) -> ReturnType) -> ReturnType {
        return function(self)
    }

    public var asString: String {
        return "\(self)"
    }

    public static func cast(_ object: Any) -> Self {
        return object as! Self
    }
}

public extension Optional {
    public var notNil: Bool {
        return self != nil
    }

    public var isNil: Bool {
        return self == nil
    }

    public var asString: String {
        if self == nil { return "" } else { return "\(self!)" }
    }

    public func notNil(_ function: (Wrapped) -> Void) {
        if self != nil { function(self!) }
    }

//
//    public func then(function: (Wrapped) -> Void) {
//        if self != nil { function(self!) }
//    }
//
//    public func get<ReturnType>(function: (Wrapped) -> ReturnType) -> ReturnType? {
//        if self != nil { return function(self!) } else { return nil }
//    }


}

public class CSObject {
}

extension NSObject: CSLang {
}

extension String: CSLang {
}

extension Array: CSLang {
}

extension Dictionary: CSLang {
}

extension CSObject: CSLang {
}