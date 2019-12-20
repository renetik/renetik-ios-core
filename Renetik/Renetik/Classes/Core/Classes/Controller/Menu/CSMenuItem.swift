//
// Created by Rene Dohan on 12/18/19.
//

import RenetikObjc
import Renetik

public class CSMenuItem: CSObject {

    let controller: CSMainController
    public var title: String?
    public var systemItem: UIBarButtonItem.SystemItem?
    public var image: UIImage?
    var view: UIView?
    var action: ((CSMenuItem) -> Void)?
    var _visible = true
    var closeMenu = true
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
        self.visible = false;
        return self
    }

    @discardableResult
    public func show() -> Self {
        self.visible = true;
        return self
    }

    public var visible: Bool {
        get { _visible }
        set(value) {
            if _visible == value { return }
            _visible = value
            updateMenu()
        }
    }

    public var hidden: Bool {
        get { !_visible }
        set(value) { visible = !value }
    }

    private func updateMenu() {
        (controller as? CSMainController).notNil { $0.updateBarItemsAndMenu() }.elseDo {
            (controller.parent as? CSMainController).notNil { $0.updateBarItemsAndMenu() }
                    .elseDo { logError("CSMainController not found") }
        }
    }

    internal func createBarButton() -> UIBarButtonItem {
        if systemItem.notNil { return UIBarButtonItem(item: systemItem!, onClick: createAction) }
        if image.notNil { return UIBarButtonItem(image: image!, onClick: createAction) }
        return UIBarButtonItem(title: title!, onClick: createAction)
    }

    private var createAction: (Any) -> Void { { _ in self.action?(self) } }

    @discardableResult
    func closeMenu(_ close: Bool) -> Self {
        self.closeMenu = close
        return self
    }

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