//
// Created by Rene Dohan on 12/17/19.
//

import UIKit
import RenetikObjc

open class CSMainController: CSViewController {

    var childMainControllers = [CSMainController]()
    public var parentMain: CSMainController? = nil
    var menu = [CSMenuHeader]()
    lazy var menuDialog = { dialog() }()

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isMainController { updateBarItemsAndMenu() }
    }

    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        menuDialog.hide()
    }

    public var isMainController: Bool { parent is UINavigationController || parentMain == nil }

    public var isChildController: Bool { !isMainController }

    public func updateBarItemsAndMenu(animated: Bool = false) {
        if isChildController {
            parentMain?.updateBarItemsAndMenu(animated: animated)
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
        for menuHeader in self.menu { if menuHeader.isVisible { menu.add(menuHeader) } }
        for controller in childMainControllers {
            if controller.isShowing { controller.onPrepare(menu: &menu) }
        }
    }

    func createActionBarItems(from menu: inout [CSMenuHeader]) -> [UIBarButtonItem] {
        var array: [UIBarButtonItem] = []
        if menu.first?.isDisplayedAsItem == true {
            array.add(menu.first!.items.first!.createBarButton())
            menu.removeFirst()
        }
        if menu.first?.isDisplayedAsItem == true {
            array.add(menu.first!.items.first!.createBarButton())
            menu.removeFirst()
        }
        if menu.first?.isDisplayedAsItem == true {
            array.add(menu.first!.items.first!.createBarButton())
            menu.removeFirst()
        }
        return array.reversed()
    }

    func onCreate(menu: [CSMenuHeader]) -> UIBarButtonItem? {
        if menu.isEmpty { return nil }
        menuDialog.clear()
        for menuHeader in menu {
            let item = menuHeader.items.first!
            menuDialog.add(title: item.title!) { item.action!(item) }
        }
        return UIBarButtonItem(image: CSMenuItem.menuImage, onClick: { sender in
            if self.menuDialog.isVisible {
                self.menuDialog.hide()
            }
            else {
                self.menuDialog.showSheetFrom(item: sender)
            }
        })
    }

    open func onPrepareRightBarButton(items: inout [UIBarButtonItem]) {
    }

    public override func addChild(_ controller: UIViewController) {
        super.addChild(controller)
        if controller is CSMainController { addChild(mainController: controller.cast()) }
    }

    @discardableResult
    public override func dismissChild(controller: UIViewController) -> UIViewController {
        super.dismissChild(controller: controller)
        if controller is CSMainController {
            childMainControllers.remove(controller.cast())
        }
        return controller
    }

    public func setChild(mainControllers: [CSMainController]) -> [CSMainController] {
        self.childMainControllers.removeAll()
        addChild(mainControllers: mainControllers)
        return childMainControllers
    }

    public func addChild(mainControllers: [CSMainController]) -> [CSMainController] {
        for controller in mainControllers { addChild(mainController: controller) }
        return childMainControllers
    }

    public func addChild(mainController: CSMainController) {
        childMainControllers.add(mainController)
        mainController.parentMain = self
    }

    open func onPrepareLeftBarItem() -> UIBarButtonItem? {
        for controller in childMainControllers {
            if controller.isShowing { return controller.onPrepareLeftBarItem() }
        }
        return nil
    }

    @discardableResult
    public func show(in parent: CSMainController) -> Self {
        let transition = CATransition()
        transition.duration = 0.15
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .moveIn
        transition.subtype = .fromBottom
        view.layer.add(transition, forKey: nil)
        parent.showChild(controller: self)
        isShowing = true
        return self
    }

    @discardableResult
    open func hideIn() -> Self {
        isShowing = false
        UIView.animate(withDuration: 0.5,
                animations: { self.view.bottom = -5 },
                completion: { finished in
                    self.view.hide()
                    self.parentMain?.dismissChild(controller: self)
                })
        return self
    }
}
