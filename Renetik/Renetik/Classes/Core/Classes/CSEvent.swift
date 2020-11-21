// Created by Rene Dohan on 9/23/19.
//

public func event<Type>() -> CSEvent<Type> { CSEvent<Type>() }

public func event() -> CSEvent<Void> { CSEvent<Void>() }

public class CSEventRegistration: CSObject {
    open func cancel() { fatalError() }
}

public struct CSEventArgument<Type> {
    public let registration: CSEventListener<Type>
    public let argument: Type
}

public class CSEventListener<Type>: CSEventRegistration {

    public typealias CSEventFunction = (CSEventListener<Type>, Type) -> Void

    private let event: CSEvent<Type>, function: CSEventFunction

    fileprivate init(event: CSEvent<Type>, function: @escaping CSEventFunction) {
        self.event = event
        self.function = function
    }

    override public func cancel() {
        event.remove(listener: self)
    }

    fileprivate func fire(_ argument: Type) {
        function(self, argument)
    }
}

public class CSEvent<Type> {

    public init() {}

    private var registrations = [CSEventListener<Type>]()

    public func fire(_ argument: Type) {
        for registration in registrations { registration.fire(argument) }
    }

    @discardableResult
    public func listen(function: @escaping (Type) -> Void) -> CSEventListener<Type> {
        registrations.add(CSEventListener(event: self, function: { _, argument in
            function(argument)
        }))
    }

    @discardableResult
    public func listen(function: @escaping (CSEventListener<Type>, Type) -> Void) -> CSEventListener<Type> {
        registrations.add(CSEventListener(event: self, function: function))
    }

    @discardableResult
    public func listenOnce(function: @escaping ArgFunc<Type>) -> CSEventListener<Type> {
        listen(function: { registration, argument in
            registration.cancel()
            function(argument)
        })
    }

    fileprivate func remove(listener: CSEventListener<Type>) {
        registrations.remove(all: listener)
    }
}

public extension CSEvent where Type == Void {
    public func fire() { fire(()) }
}