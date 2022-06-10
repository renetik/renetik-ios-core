public class CSAlertDialog: CSObject, CSHasDialogProtocol, CSHasDialogVisible, CSHasSheetProtocol {

    private let controller: UIViewController
    private var alert: UIAlertController!

    public init(in controller: UIViewController) {
        self.controller = controller
    }

    public var isDialogVisible: Bool { alert.notNil }

    public func hideDialog(animated: Bool) { alert?.dismiss(animated: animated) }

    public func show(title: String?, message: String?, actions: [CSDialogAction]?, positive: CSDialogAction?,
        cancel: CSDialogAction?, from element: CSDisplayElement) -> CSHasDialogVisible {
        hideDialog(animated: false)
        self.alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions?.forEach { action in alert.add(action: action, style: .default) }
        positive.notNil { action in alert.add(action: action, style: .destructive, preferred: true) }
        cancel.notNil { action in alert.add(action: action, style: .cancel) }
        present(from: element)
        return self
    }

    public func show(title: String?, message: String, positive: CSDialogAction?,
        negative: CSDialogAction?, cancel: CSDialogAction?) -> CSHasDialogVisible {
        hideDialog(animated: false)
        alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        negative.notNil { action in alert.add(action: action, style: .destructive) }
        positive.notNil { action in alert.add(action: action, style: .default, preferred: true) }
        if cancel?.title != nil { alert.add(action: cancel!, style: .cancel) }
        present()
        return self
    }

    func present(from element: CSDisplayElement) {
        element.view.notNil { present(from: $0) }
        element.item.notNil { present(from: $0) }
    }

    func present(from view: UIView) {
        alert.modalPresentationStyle = .popover
        alert.popoverPresentationController?.sourceView = view.superview
        alert.popoverPresentationController?.sourceRect = view.frame
        present()
    }

    func present(from item: UIBarButtonItem) {
        alert.modalPresentationStyle = .popover
        alert.popoverPresentationController?.barButtonItem = item
        present()
    }

    func present() {
        controller.present(alert, animated: true, completion: nil)
    }
}

public extension UIAlertController {
    @discardableResult
    func add(action: CSDialogAction, style: UIAlertAction.Style, preferred: Bool = false) -> UIAlertAction {
        UIAlertAction(title: action.title, style: style) { _ in action.action() }.also {
            addAction($0)
            if preferred { preferredAction = $0 }
        }
    }
}
