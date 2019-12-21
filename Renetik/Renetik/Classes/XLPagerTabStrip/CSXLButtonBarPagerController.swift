//
// Created by Rene Dohan on 12/17/19.
//

import Foundation
import UIKit
import RenetikObjc
import XLPagerTabStrip

public typealias CSXLButtonBarPagerChildController = CSMainController & IndicatorInfoProvider

public class CSXLButtonBarPagerController: ButtonBarPagerTabStripViewController {

    private(set) var controllers: [CSXLButtonBarPagerChildController]!
    var currentController: CSXLButtonBarPagerChildController { controllers[currentIndex] }
    var selectedIndex: Int { currentIndex }

    private var parentController: CSMainController!
    private var buttonBarViewHeightBeforeHide: CGFloat = 0

    public func construct(by parent: CSMainController, controllers: [CSXLButtonBarPagerChildController]) -> Self {
        parentController = parent
        self.controllers = controllers
        parent.showChild(controller: self)
        parent.addChild(mainControllers: controllers)
        return self
    }

    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        controllers
    }

    override public func viewWillLayoutSubviews() { if controllers.hasItems { super.viewWillLayoutSubviews() } }

    override public func viewDidLoad() {
        super.viewDidLoad()
        updateControllersVisible(at: currentIndex, animated: false)
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadPagerTabStripView()
    }

    public override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int) {
        super.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex)
        updateControllersVisible(at: currentIndex, animated: true)
    }

    public override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
        super.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex, withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
        if progressPercentage == 1 { updateControllersVisible(at: currentIndex, animated: false) }
    }

    func updateControllersVisible(at index: Int, animated: Bool) {
        for controller in controllers { controller.isShowing = false }
        currentController.isShowing = true
        parentController.updateBarItemsAndMenu(animated: animated)
    }

    public func load(controllers: [CSXLButtonBarPagerChildController]) {
        self.controllers = controllers
        parentController.addChild(mainControllers: self.controllers)
        reloadPagerTabStripView()
        updateControllersVisible(at: currentIndex, animated: false)
    }

    public func add(controller: (CSXLButtonBarPagerChildController)) {
        controllers.add(controller)
        parentController.addChild(mainController: controller)
        reloadPagerTabStripView()
        updateControllersVisible(at: currentIndex, animated: false)
    }

    override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            self.reloadPagerTabStripView()
            self.updateControllersVisible(at: self.currentIndex, animated: false)
        }
    }

    public func setBar(visible: Bool) {
        if visible {
            if buttonBarViewHeightBeforeHide == 0 { return }
            buttonBarView.height = buttonBarViewHeightBeforeHide
            containerView.height(fromTop: buttonBarViewHeightBeforeHide)
            buttonBarViewHeightBeforeHide = 0
        }
        else {
            buttonBarViewHeightBeforeHide = buttonBarView.height
            buttonBarView.height = 0
            containerView.height(fromTop: 0)
        }
    }
}
