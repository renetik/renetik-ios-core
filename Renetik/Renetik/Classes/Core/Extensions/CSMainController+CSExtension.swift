//
//  CSMainController.swift
//  Renetik
//
//  Created by Rene Dohan on 3/14/19.
//

import Foundation
import RenetikObjc

@objc public extension CSMainController {
    @discardableResult
    @objc public func menuHeader(title: String = "") -> CSMenuHeader {
        return menu.put(CSMenuHeader().construct(self, menu.count, title))
            as! CSMenuHeader
    }

    @discardableResult
    @objc public func menuItem(title: String = "",
                               onClick: ((CSMenuItem) -> Void)? = nil) -> CSMenuItem {
        let item = menuHeader().item(title)
        onClick.notNil { item.onClick($0) }
        return item
    }

    @discardableResult
    @objc public func menuItem(onClick: ((CSMenuItem) -> Void)? = nil) -> CSMenuItem {
        return menuItem(title: "", onClick: onClick)
    }

    @discardableResult
    @objc public func menuItem(view: UIView,
                               onClick: ((CSMenuItem) -> Void)? = nil) -> CSMenuItem {
        return menuItem(onClick: onClick).apply { $0.view = view }
    }

    @discardableResult
    @objc public func menuItem(image: UIImage,
                               onClick: ((CSMenuItem) -> Void)? = nil) -> CSMenuItem {
        return menuItem(onClick: onClick).apply { $0.image = image }
    }

    @discardableResult
    @objc public func menuItem(type: UIBarButtonItem.SystemItem,
                               onClick: ((CSMenuItem) -> Void)? = nil) -> CSMenuItem {
        return menuItem(onClick: onClick).apply { $0.systemItem = type }
    }
}
