//
// Created by Rene Dohan on 12/17/19.
//

import UIKit

open class CSMainController: CSViewController {

    public var parentMainController: CSMainController? = nil
    private var childMainControllers = [CSMainController]()
    private var menuItems = [CSMenuHeader]()
    private lazy var menuDialog = { CSAlertDialogController(in: self) }()

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isTopController { updateBarItemsAndMenu() }
    }

    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        menuDialog.hideDialog()
    }

    public var isTopController: Bool { parent is UINavigationController || parentMainController == nil }

    public var isChildController: Bool { !isTopController }

    public func updateBarItemsAndMenu(animated: Bool = false) {
        if isChildController {
            parentMainController?.updateBarItemsAndMenu(animated: animated)
            return
        }
        var menu = [CSMenuHeader]()
        onPrepare(menu: &menu)
        let actionItems = createActionBarItems(from: &menu)
        let barMenuItem = onCreate(menu: menu)
        var barItems = [UIBarButtonItem]()
        if barMenuItem != nil { barItems.add(barMenuItem!) }
        barItems.add(array: actionItems)
        onPrepareRightBarButton(items: &barItems)
        navigationItem.rightBarButtonItems = barItems
        navigationItem.setLeftBarButton(onPrepareLeftBarItem(), animated: animated)
    }

    func onPrepare(menu: inout [CSMenuHeader]) {
        for menuHeader in menuItems { if menuHeader.isVisible { menu.add(menuHeader) } }
        for controller in childMainControllers { if controller.isShowing { controller.onPrepare(menu: &menu) } }
    }

    func createActionBarItems(from menu: inout [CSMenuHeader]) -> [UIBarButtonItem] {
        var array: [UIBarButtonItem] = []
        if menu.first?.isDisplayedAsItem == true {
            array.add(menu.first!.items.first!.createButtonItem())
            menu.removeFirst()
        }
        if menu.first?.isDisplayedAsItem == true {
            array.add(menu.first!.items.first!.createButtonItem())
            menu.removeFirst()
        }
        if menu.first?.isDisplayedAsItem == true {
            array.add(menu.first!.items.first!.createButtonItem())
            menu.removeFirst()
        }
        return array.reversed()
    }

    func onCreate(menu: [CSMenuHeader]) -> UIBarButtonItem? {
        if menu.isEmpty { return nil }
        var actions = [CSDialogAction]()
        for header in menu {
            let item = header.items.first!
            actions.add(CSDialogAction(title: item.title!) { item.action!(item) })
        }
        return UIBarButtonItem(image: CSMenuItem.menuImage) { item in
            self.menuDialog.show(actions: actions, from: item)
        }
    }

    open func onPrepareRightBarButton(items: inout [UIBarButtonItem]) {}

    public override func addChild(_ controller: UIViewController) {
        super.addChild(controller)
        (controller as? CSMainController).notNil { addChildMain(controller: $0) }
    }

    @discardableResult
    public override func dismissChild(controller: UIViewController) -> UIViewController {
        super.dismissChild(controller: controller)
        (controller as? CSMainController)?.also { childMainControllers.remove($0) }
        return controller
    }

    public func setChildMain(controllers: [CSMainController]) -> [CSMainController] {
        childMainControllers.removeAll()
        addChildMain(controllers: controllers)
        return childMainControllers
    }

    public func addChildMain(controllers: [CSMainController]) -> [CSMainController] {
        for controller in controllers { addChildMain(controller: controller) }
        return childMainControllers
    }

    public func addChildMain(controller: CSMainController) {
        childMainControllers.add(controller)
        controller.parentMainController = self
    }

    public func removeChildMain(controllers: [CSMainController]) -> Self {
        for controller in controllers { removeChildMain(controller: controller) }
        return self
    }

    public func removeChildMain(controller: CSMainController) {
        dismissChild(controller: controller)
    }

    open func onPrepareLeftBarItem() -> UIBarButtonItem? {
        for controller in childMainControllers {
            if controller.isShowing { return controller.onPrepareLeftBarItem() }
        }
        return nil
    }

    @discardableResult
    public func menuAdd(header title: String = "") -> CSMenuHeader {
        menuItems.add(CSMenuHeader(by: self, index: menuItems.count, title: title))
    }
}
