//
//  CSMainController.swift
//  Renetik
//
//  Created by Rene Dohan on 3/14/19.
//

import Foundation
import RenetikObjc

public extension CSMainController {
    @discardableResult
    public func menuHeader(title: String = "") -> CSMenuHeader {
        menu.add(CSMenuHeader(by: self, index: menu.count, title: title))
    }

    @discardableResult
    public func menuItem(title: String = "", image: UIImage? = nil,
                         type: UIBarButtonItem.SystemItem? = nil,
                         onClick: ((CSMenuItem) -> Void)? = nil) -> CSMenuItem {
        menuHeader().item(with: title, type: type, image: image, action: onClick)
    }


    @discardableResult
    public func menuItem(view: UIView,
                         onClick: ((CSMenuItem) -> Void)? = nil) -> CSMenuItem {
        menuHeader().item(with: view, action: onClick)
    }
}
