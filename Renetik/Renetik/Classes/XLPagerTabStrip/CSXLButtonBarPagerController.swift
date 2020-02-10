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
    private var currentController: CSXLButtonBarPagerChildController { controllers[currentIndex] }
    private var parentController: CSMainController!
    private var isViewDidAppear = false

    public func construct(by parent: CSMainController, controllers: [CSXLButtonBarPagerChildController]) -> Self {
        parentController = parent
        self.controllers = controllers
        parent.showChild(controller: self)
        parent.addChildMain(controllers: controllers)
        settings.style.buttonBarHeight.isNil { self.settings.style.buttonBarHeight = 44 }
        return self
    }

    override public func viewControllers(
            for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] { controllers }

//    override open func viewDidLayoutSubviews() { if controllers.hasItems { super.viewDidLayoutSubviews() } }

//    override public func viewWillLayoutSubviews() { if controllers.hasItems { super.viewWillLayoutSubviews() } }

    override public func viewDidLoad() {
        super.viewDidLoad()
        updateControllersVisible(at: currentIndex, animated: false)
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isViewDidAppear {
            isViewDidAppear = true
            reloadPagerTabStripView()
        }
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
        parentController.addChildMain(controllers: self.controllers)
        reloadPagerTabStripView()
        updateControllersVisible(at: currentIndex, animated: false)
    }

    public func add(controller: (CSXLButtonBarPagerChildController)) {
        controllers.add(controller)
        parentController.addChildMain(controller: controller)
        reloadPagerTabStripView()
        updateControllersVisible(at: currentIndex, animated: false)
    }

    override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.onCompletion { _ in
            self.containerView.scroll(toPage: self.currentIndex, of: self.controllers.count)
//            doLater { self.reloadPagerTabStripView() }
        }
    }

    public func setBar(visible: Bool) {
        if visible {
            buttonBarView.height = settings.style.buttonBarHeight!
            containerView.height(fromTop: settings.style.buttonBarHeight!)
        } else {
            buttonBarView.height = 0
            containerView.height(fromTop: 0)
        }
    }

    override open func updateContent() {
        super.updateContent()
        for (index, childController) in controllers.enumerated() {
            childController.view.frame = CGRect(x: offsetForChild(at: index) + view.safeAreaInsets.left,
                    y: 0, width: view.bounds.width - (view.safeAreaInsets.left + view.safeAreaInsets.right),
                    height: containerView.bounds.height)
        }
    }
}
