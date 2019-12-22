//
// Created by Rene Dohan on 12/18/19.
//

import RenetikObjc
import Renetik

public class CSMenuItem: CSObject {

    private let controller: CSMainController
    public var title: String? {
        didSet { updateMenu() }
    }
    public var systemItem: UIBarButtonItem.SystemItem? {
        didSet { updateMenu() }
    }
    public var image: UIImage? {
        didSet { updateMenu() }
    }
    public var isVisible = true {
        didSet { updateMenu() }
    }
    var action: ((CSMenuItem) -> Void)?
    var view: UIView?
    var isNoActionItem = false
    var index = 0

    public init(by parent: CSMainController, title: String? = nil,
                systemItem: UIBarButtonItem.SystemItem? = nil,
                image: UIImage? = nil,
                action: ((CSMenuItem) -> Void)? = nil) {
        controller = parent
        self.title = title
        self.systemItem = systemItem
        self.image = image
        self.action = action
    }

    public init(by parent: CSMainController, view: UIView? = nil, action: ((CSMenuItem) -> Void)? = nil) {
        controller = parent
        self.view = view
        self.action = action
    }

    @discardableResult
    public func hide() -> Self {
        self.isVisible = false;
        return self
    }

    @discardableResult
    public func show() -> Self {
        self.isVisible = true;
        return self
    }

    public var hidden: Bool {
        get { !isVisible }
        set(value) { isVisible = !value }
    }

    private func updateMenu() {
        if !controller.isViewLoaded { return }
        (controller as? CSMainController).notNil { $0.updateBarItemsAndMenu() }.elseDo {
            (controller.parent as? CSMainController).notNil { $0.updateBarItemsAndMenu() }
                    .elseDo { logError("CSMainController not found") }
        }
    }

    internal func createBarButton() -> UIBarButtonItem {
        if systemItem.notNil { return UIBarButtonItem(item: systemItem!, onClick: onBarButtonClick) }
        if image.notNil { return UIBarButtonItem(image: image!, onClick: onBarButtonClick) }
        return UIBarButtonItem(title: title!, onClick: onBarButtonClick)
    }

    private var onBarButtonClick: (Any) -> Void { { _ in self.action!(self) } }

    @discardableResult
    func set(view: UIView) -> Self {
        self.view = view
        return self
    }

    @discardableResult
    public func noAction() -> Self {
        isNoActionItem = true
        return self
    }
}