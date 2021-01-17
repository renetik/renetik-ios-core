//
// Created by Rene Dohan on 3/15/20.
//

import Foundation
import RenetikObjc

public class CSArray<Type>: CSObject {

    let array = NSMutableArray()

    public var isEmpty: Bool { array.empty }

    public var isSet: Bool { !isEmpty }

    public var asArray: [Type] { array as! [Type] }

    public var count: Int { array.count }

    public func get(_ index: Int) -> Type { array[index] as! Type }

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

extension CSArray: Collection {
    public func index(after index: Int) -> Int { index + 1 }

    public var startIndex: Int { 0 }

    public var endIndex: Int { array.count - 1 }

    public typealias Element = Type

    public typealias Index = Int

    public subscript(index: Index) -> Type { get { array[index] as! Type } }
}
