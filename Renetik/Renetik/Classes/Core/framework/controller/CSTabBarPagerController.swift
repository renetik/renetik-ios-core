import Renetik

public typealias CSTabBarPagerControllerItem = (item: UITabBarItem, onClick: (@escaping (UIViewController) -> Void) -> Void)

public class CSTabBarPagerController: CSMainController, UITabBarDelegate {

    private let containerView = CSView.construct().background(.clear)
    public lazy var tabBar = UITabBar(frame: .zero).construct()
    private var onClicksDictionary = [UITabBarItem: (callback: @escaping (UIViewController) -> Void) -> Void]()
    private var currentController: UIViewController?
    private var currentControllerIndex: Int?

    @discardableResult
    public func construct(with parent: CSViewController, items: [CSTabBarPagerControllerItem]) -> Self {
        super.construct(parent)
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
        view.add(view: containerView).matchParent().fill(bottom: 0, from: tabBar)
    }

    override public func onViewDidLayout() {
        super.onViewDidLayout()
        tabBar.resizeToFit().from(bottom: 0)
        containerView.fill(bottom: tabBar.topFromBottom)
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
        add(controller: controller, to: containerView).view.matchParent()
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