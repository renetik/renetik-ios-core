//
// Created by Rene Dohan on 12/18/19.
//

import Foundation

public class CSMenuHeader: CSObject {

    var items = [CSMenuItem]()
    let controller: CSMainController
    let index: Int
    let title: String

    public init(by parent: CSMainController, index: Int, title: String) {
        self.controller = parent
        self.index = index
        self.title = title
    }

    func item(with title: String, type: UIBarButtonItem.SystemItem? = nil,
              image: UIImage? = nil, action: ((CSMenuItem) -> Void)? = nil) -> CSMenuItem {
        items.add(CSMenuItem(by: controller, title: title, systemItem: type, image: image, action: action))
                .also { $0.index = items.size - 1 }
    }

    func item(with view: UIView, action: ((CSMenuItem) -> Void)? = nil) -> CSMenuItem {
        items.add(CSMenuItem(by: controller, view: view, action: action)).also { $0.index = items.size - 1 }
    }

    public func visible() -> Bool {
        for item in items { if item.visible { return true } }
        return false
    }

    public func clear() -> Self {
        items.removeAll()
        return self
    }

    public var isDisplayedAsItem: Bool { title.isEmpty && items.count == 1 && !items.first!.isNoActionItem }
}
