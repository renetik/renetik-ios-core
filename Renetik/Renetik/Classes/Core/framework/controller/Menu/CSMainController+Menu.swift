//
// Created by Rene Dohan on 01/06/22.
//
import Foundation

public extension CSMainController {
    @discardableResult
    public func menu(title: String = "", image: UIImage? = nil,
                     type: UIBarButtonItem.SystemItem? = nil,
                     onClick: ((CSMenuItem) -> Void)? = nil) -> CSMenuItem {
        menuAdd().item(with: title, type: type, image: image, action: onClick)
    }

    @discardableResult
    public func menu(title: String = "", image: UIImage? = nil,
                     type: UIBarButtonItem.SystemItem? = nil,
                     onClick: Func? = nil) -> CSMenuItem {
        menuAdd().item(with: title, type: type, image: image, action: { _ in onClick?() })
    }

    @discardableResult
    public func menu(view: UIView,
                     onClick: ((CSMenuItem) -> Void)? = nil) -> CSMenuItem {
        menuAdd().item(with: view, action: onClick)
    }
}
