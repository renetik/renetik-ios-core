////
//// Created by Rene Dohan on 12/22/19.
////
//
//import Foundation
//import UIKit
//import RenetikObjc
//
//public protocol CSResponseController {
//    func show<T: AnyObject>(_ response: CSResponse<T>, _ progress: Bool,
//                            _ failedDialog: Bool, _ onSuccess: ((T) -> Void)?) -> CSResponse<T>
//}
//
//public extension CSResponseController {
//    @discardableResult
//    public func show<Data: AnyObject>(_ response: CSResponse<Data>,
//                                      progress: Bool = true, failedDialog: Bool = true,
//                                      onSuccess: ((Data) -> Void)? = nil) -> CSResponse<Data> {
////        response.controller = self
////        if progress {
////            let progress = show(progress: "")
////            response.onDone { _ in progress.hide() }
////        }
////        if failedDialog { response.onFailed { it in self.show(message: it.message) } }
////        onSuccess.isNotNil { response.onSuccess($0) }
//        show(response, progress, failedDialog, onSuccess)
//    }
//}