//
// Created by Rene Dohan on 9/19/19.
// Copyright (c) 2019 Renetik Software. All rights reserved.
//

import RenetikObjc
import Renetik

public typealias CSTabBarPagerControllerItem = (item: UITabBarItem, onClick: (@escaping (UIViewController) -> Void) -> Void)

public class CSTabBarPagerController: CSMainController, UITabBarDelegate {

    private let containerView = UIView.construct().background(.clear)
    public lazy var tabBar = UITabBar(frame: .zero).construct()
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
        tabBar.delegate = self
        tabBar.items = barButtonItems
        tabBar.selectedItem = barButtonItems.first

        items.first.notNil { item in
            item.onClick { controller in
                self.show(controller: controller)
            }
        }
        return self
    }

    override public func onViewWillAppearFirstTime() {
        super.onViewWillAppearFirstTime()
        view.add(view: tabBar).resizeToFit().flexibleTop().matchParentWidth().from(bottom: 0)
        view.add(view: containerView).matchParent().margin(bottom: 0, from: tabBar)
    }

    override public func onViewDidLayout() {
        super.onViewDidLayout()
        tabBar.resizeToFit().from(bottom: 0)
        containerView.margin(bottom: tabBar.topFromBottom)
    }

    public func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if currentControllerIndex == tabBar.selectedIndex {
            return
        }
        onClicksDictionary[item]! {
            self.show(controller: $0)
        }
    }

    private func show(controller: UIViewController) {
        currentController.notNil {
            dismissChild(controller: $0)
            if currentControllerIndex! < tabBar.selectedIndex {
                CATransition.create(for: containerView, type: .push, subtype: .fromRight)
            } else if currentControllerIndex! > tabBar.selectedIndex {
                CATransition.create(for: containerView, type: .push, subtype: .fromLeft)
            }
        }
        showChild(controller: controller, parentView: containerView).view.matchParent()
        updateBarItemsAndMenu()
        currentController = controller
        currentControllerIndex = tabBar.selectedIndex
    }

    public func updateTabSelection() {
        if tabBar.selectedIndex != currentControllerIndex! {
            tabBar.selectedIndex = currentControllerIndex!
        }
    }

    public func select(item: UITabBarItem) {
        tabBar.selectedItem = item
        tabBar(tabBar, didSelect: item)
    }
}