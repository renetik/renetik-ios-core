//
// Created by Rene Dohan on 9/23/19.
//

public func event<Type>() -> CSEvent<Type> { CSEvent<Type>() }

public struct CSEventArgument<Type> {
    public let registration: CSEventRegistration<Type>
    public let argument: Type
}

public class CSEventRegistration<Type>: CSObject {

    private let event: CSEvent<Type>, function: (CSEventArgument<Type>) -> Void

    fileprivate init(event: CSEvent<Type>, function: @escaping (CSEventArgument<Type>) -> Void) {
        self.event = event
        self.function = function
    }

    public func cancel() {
        event.remove(self)
    }

    fileprivate func fire(_ argument: Type) {
        function(CSEventArgument(registration: self, argument: argument))
    }
}

public class CSEvent<Type> {

    private var registrations = [CSEventRegistration<Type>]()

    public func fire(_ argument: Type) {
        for registration in registrations { registration.fire(argument) }
    }

    @discardableResult
    public func add(_ function: @escaping (CSEventArgument<Type>) -> Void) -> CSEventRegistration<Type> {
        registrations.add(CSEventRegistration(event: self, function: function))
    }

    fileprivate func remove(_ functionToRemove: CSEventRegistration<Type>) {
        registrations.removeAll(functionToRemove)
    }
}

public extension CSEvent where Type == Void {
    public func fire() {
        fire(())
    }
}