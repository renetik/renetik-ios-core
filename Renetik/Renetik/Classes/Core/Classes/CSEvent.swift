// Created by Rene Dohan on 9/23/19.
//

public func event<Type>() -> CSEvent<Type> { CSEvent<Type>() }

public class CSEventRegistration: CSObject {
    open func cancel() { fatalError() }
}

public struct CSEventArgument<Type> {
    public let registration: CSEventListener<Type>
    public let argument: Type
}

public class CSEventListener<Type>: CSEventRegistration {

    private let event: CSEvent<Type>, function: (CSEventArgument<Type>) -> Void

    fileprivate init(event: CSEvent<Type>, function: @escaping (CSEventArgument<Type>) -> Void) {
        self.event = event
        self.function = function
    }

    override public func cancel() {
        event.remove(listener: self)
    }

    fileprivate func fire(_ argument: Type) {
        function(CSEventArgument(registration: self, argument: argument))
    }
}

public class CSEvent<Type> {

    public init() {}

    private var registrations = [CSEventListener<Type>]()

    public func fire(_ argument: Type) {
        for registration in registrations { registration.fire(argument) }
    }

    @discardableResult
    public func invoke(listener: @escaping (CSEventArgument<Type>) -> Void) -> CSEventListener<Type> {
        registrations.add(CSEventListener(event: self, function: listener))
    }

    @discardableResult
    public func invoke(listener: @escaping () -> Void) -> CSEventListener<Type> {
        invoke(listener: { _ in listener() })
    }

    public func remove(listener: CSEventListener<Type>) {
        registrations.remove(all: listener)
    }
}

public extension CSEvent where Type == Void {

    public func fire() { fire(()) }

    @discardableResult
    public func invokeOnce(listener: @escaping () -> Void) -> CSEventListener<Type> {
        invoke(listener: { argument in
            argument.registration.cancel()
            listener()
        })
    }
}

public extension CSEvent where Type: AnyObject, Type: CSAny {
    @discardableResult
    public func invokeOnce(listener: @escaping (Type) -> Void) -> CSEventListener<Type> {
        invoke(listener: { argument in
            argument.registration.cancel()
            listener(argument.argument)
        })
    }
}