//
// Created by Rene Dohan on 3/15/20.
//

import Foundation

public class CSArray<Type>: CSObject {

    public let array = NSMutableArray()

    public var isEmpty: Bool { array.isEmpty }

    public var isSet: Bool { !isEmpty }

    public var asArray: [Type] { array as! [Type] }

    public var count: Int { array.count }

    public func get(_ index: Int) -> Type { array[index] as! Type }

    @discardableResult
    public func add(_ element: Type) -> Type { array.add(element); return element }

    @discardableResult
    public func remove(_ element: Type) -> Self { array.remove(element); return self }

    @discardableResult
    public func reload(_ data: [Type]) -> Self { array.reload(data); return self }

    @discardableResult
    public func removeAll() -> Self { array.removeAllObjects(); return self }

    @discardableResult
    public func clear() -> Self { removeAll() }
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
