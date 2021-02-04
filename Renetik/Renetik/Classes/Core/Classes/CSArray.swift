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

    @discardableResult
    public func reload(_ data: [Type]) -> Self { array.reload(data); return self }

    @discardableResult
    public func removeAll() -> Self { array.removeAllObjects(); return self }

}

extension CSArray: Collection {
    public typealias Element = Type

    public func index(after i: Int) -> Int { asArray.index(after: i) }

    public var startIndex: Int { asArray.startIndex }

    public var endIndex: Int { asArray.endIndex }

    public subscript(position: Int) -> Element { asArray[position] }
}

extension CSArray {
    public func isSet(function: (CSArray) -> Void) {
        if isSet { function(self) }
    }
}
