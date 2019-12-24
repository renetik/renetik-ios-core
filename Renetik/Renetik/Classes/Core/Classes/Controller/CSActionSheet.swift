////
//// Created by Rene Dohan on 12/22/19.
////
//
//import Foundation
//
//public class CSActionSheet: CSObject {
//
//    let controller: UIViewController
//    let title: String
//    let message: String
//    var alert: UIAlertController!
//
//    init(_ controller: UIViewController, _ title: String = "", _ message: String = "") {
//        self.controller = controller
//        self.title = title
//        self.message = message
//    }
//
//
//
//
//    func show(from barItem: UIBarButtonItem) {
//        alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: defaultActionTitle, style: .default, handler: nil))
////        alert.popoverPresentationController?.barButtonItem = item
////        alert.popoverPresentationController?.sourceView = self.view;
//        controller.present(alert, animated: true, completion: nil)
//    }
//}