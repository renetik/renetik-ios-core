////
//// Created by Rene Dohan on 1/11/20.
////
//
//import Foundation
//
//public protocol CSStringConvertibleProtocol {
//    var asString: String { get }
//}
//
//public extension CSStringConvertibleProtocol where Self: CustomStringConvertible {
//    var asString: String { description }
//}
//
//public extension CSStringConvertibleProtocol where Self: CSNameProtocol {
//    var asString: String { name }
//}
//
//public extension CSStringConvertibleProtocol where T == String, Self: CSValueProtocol {
//    public var asString: String { value }
//}
//
//extension Optional: CSStringConvertibleProtocol {
//}