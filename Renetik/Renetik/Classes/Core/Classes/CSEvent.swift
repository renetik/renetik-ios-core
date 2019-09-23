////
//// Created by Rene Dohan on 9/23/19.
////
//
//import Foundation
//
//@objc public class CSEvent {
//    var callbacks = [() -> Void]()
//
//    func run() {
//        for function in callbacks {
//            function()
//        }
//    }
//
//    @objc func add(function: @escaping () -> Void) -> CSEventRegistration {
//        callbacks.put(function)
//        return CSEventRegistration(event: self, function: function)
//    }
//
//    func remove(function: @escaping () -> Void) {
//        callbacks.removeAll { $0 == function }
//    }
//}
//
//@objc public class CSEventRegistration {
//    let event: CSEvent, function: @escaping () -> Void
//
//    init(event: CSEvent, function: @escaping () -> Void) {
//        self.event = event
//        self.function = function
//    }
//
//    @objc public func cancel() {
//        event.remove(block)
//    }
//}
