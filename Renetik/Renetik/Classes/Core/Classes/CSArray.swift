//
// Created by Rene Dohan on 3/15/20.
//

import Foundation
import RenetikObjc

public class CSArray<Type>: CSObject {

    private let array = NSMutableArray()

    public var isEmpty: Bool { array.empty }

    public var asArray: [Type] { array as! [Type] }

    @discardableResult
    public func add(_ value: Type) -> Type { array.add(value); return value }

    @discardableResult
    public func remove(_ response: Type) -> Self { array.remove(response); return self }

    @discardableResult
    public func forEach(_ function: (Type) -> Void) -> Self {
        array.forEach { element in function(element as! Type) }
        return self
    }
}
