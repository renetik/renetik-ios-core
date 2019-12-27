//
// Created by Rene Dohan on 9/19/19.
// Copyright (c) 2019 Renetik Software. All rights reserved.
//

import RenetikObjc
import Renetik

public typealias CSTabBarPagerControllerItem = (item: UITabBarItem, onClick: (@escaping (UIViewController) -> Void) -> Void)

public class CSTabBarPagerController: CSMainController, UITabBarDelegate {

    private let containerView = UIView.construct().background(.clear)
    public lazy var bottomBar = UITabBar(frame: .zero).construct()
    private var onClicksDictionary = [UITabBarItem: (callback: @escaping (UIViewController) -> Void) -> Void]()
    private var currentController: UIViewController?
    private var currentControllerIndex: Int?
    private var parentController: CSMainController!

    @discardableResult
    public func construct(with parent: CSMainController, items: [CSTabBarPagerControllerItem]) -> Self {
        parentController = parent
        var barButtonItems = [UITabBarItem]()
        items.forEach {
            barButtonItems.add($0.item)
            onClicksDictionary[$0.item] = $0.onClick
        }
        bottomBar.delegate = self
        bottomBar.items = barButtonItems
        bottomBar.selectedItem = barButtonItems.first

        items.first.notNil { item in
            item.onClick { controller in
                self.show(controller: controller)
            }
        }
        return self
    }

    override public func onViewWillAppearFirstTime() {
        super.onViewWillAppearFirstTime()
        view.add(view: bottomBar).sizeFit().flexibleTop().matchParentWidth().from(bottom: 0)
        view.add(view: containerView).matchParent().height(fromBottom: bottomBar.topFromBottom)
    }

    override public func onViewDidLayout() {
        super.onViewDidLayout()
        bottomBar.sizeFit().from(bottom: 0)
        containerView.height(fromBottom: bottomBar.topFromBottom)
    }

    public func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if currentControllerIndex == bottomBar.selectedItemIndex {
            return
        }
        onClicksDictionary[item]! {
            self.show(controller: $0)
        }
    }

    private func show(controller: UIViewController) {
        currentController.notNil {
            dismissChild(controller: $0)
            if currentControllerIndex! < bottomBar.selectedItemIndex {
                CATransition.create(for: containerView, type: .push, subtype: .fromRight)
            }
            else if currentControllerIndex! > bottomBar.selectedItemIndex {
                CATransition.create(for: containerView, type: .push, subtype: .fromLeft)
            }
        }
        showChild(controller: controller, parentView: containerView).view.matchParent()
        updateBarItemsAndMenu()
        currentController = controller
        currentControllerIndex = bottomBar.selectedItemIndex
    }

    public func updateTabSelection() {
        if bottomBar.selectedItemIndex != currentControllerIndex! {
            bottomBar.selectedItemIndex = currentControllerIndex!
        }
    }

    public func select(item: UITabBarItem) {
        bottomBar.selectedItem = item
        tabBar(bottomBar, didSelect: item)
    }
}