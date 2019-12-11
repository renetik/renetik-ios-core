//
// Created by Rene Dohan on 9/23/19.
//

public func event<Type>() -> CSEvent<Type> { CSEvent<Type>() }

private class Function<Type>: NSObject {
    let value: (Type) -> Void

    init(_ function: @escaping (Type) -> Void) {
        value = function
    }
}

public class CSEvent<Type> {

    private var callbacks = [Function<Type>]()

    public func fire(_ argument: Type) {
        for function in callbacks { function.value(argument) }
    }

    @discardableResult
    public func add(_ function: @escaping (Type) -> Void) -> CSEventRegistration<Type> {
        CSEventRegistration(event: self, function: callbacks.add(Function(function)))
    }

    fileprivate func remove(_ functionToRemove: Function<Type>) {
        callbacks.removeAll { (function: Function<Type>) in functionToRemove == function }
    }
}

public class CSEventRegistration<Type> {

    private let event: CSEvent<Type>, function: Function<Type>

    fileprivate init(event: CSEvent<Type>, function: Function<Type>) {
        self.event = event
        self.function = function
    }

    public func cancel() {
        event.remove(function)
    }
}
