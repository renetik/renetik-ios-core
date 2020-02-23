//
// Created by Rene Dohan on 2/16/20.
//

import Foundation
import UIKit
import RenetikObjc
import XLPagerTabStrip

public class CSXLButtonBarPagerControllerNew: CSMainController, PagerTabStripIsProgressiveDelegate {

    public let pager = CSButtonBarPagerTabStripViewController()
    private(set) var controllers: [CSXLButtonBarPagerChildController]!
    private var currentController: CSXLButtonBarPagerChildController { controllers[pager.currentIndex] }
    private var parentController: CSMainController!

    @discardableResult
    public func construct(by parent: CSMainController, controllers: [CSXLButtonBarPagerChildController]) -> Self {
        parentController = parent
        self.controllers = controllers
        parentController.showChild(controller: self).view.matchParent()
        showChild(controller: pager.construct(self)).view.matchParent()
        addChildMain(controllers: controllers)
        pager.settings.style.buttonBarHeight.isNil { self.pager.settings.style.buttonBarHeight = 44 }
        pager.delegate = self
        return self
    }

    public override func onViewWillAppearFirstTime() {
        super.onViewWillAppearFirstTime()
        updateControllersVisible(at: pager.currentIndex, animated: false)
    }

    public override func onViewDidAppearFirstTime() {
        super.onViewDidAppearFirstTime()
        pager.reloadPagerTabStripView()
    }

    public func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int) {
        updateControllersVisible(at: pager.currentIndex, animated: true)
    }

    public func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
        if progressPercentage == 1 { updateControllersVisible(at: pager.currentIndex, animated: false) }
    }

    func updateControllersVisible(at index: Int, animated: Bool) {
        for controller in controllers { controller.isShowing = false }
        currentController.isShowing = true
        parentController.updateBarItemsAndMenu(animated: animated)
    }

    public func load(controllers: [CSXLButtonBarPagerChildController]) {
        self.controllers = controllers
        parentController.addChildMain(controllers: self.controllers)
        pager.reloadPagerTabStripView()
        updateControllersVisible(at: pager.currentIndex, animated: false)
    }

    public func add(controller: (CSXLButtonBarPagerChildController)) {
        controllers.add(controller)
        parentController.addChildMain(controller: controller)
        pager.reloadPagerTabStripView()
        updateControllersVisible(at: pager.currentIndex, animated: false)
    }

    override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.onCompletion { _ in
            self.pager.containerView.scroll(toPage: self.pager.currentIndex, of: self.controllers.count)
        }
    }

    public func setBar(visible: Bool) {
        if visible {
            pager.buttonBarView.height = pager.settings.style.buttonBarHeight!
            pager.containerView.height(fromTop: pager.settings.style.buttonBarHeight!)
        } else {
            pager.buttonBarView.height = 0
            pager.containerView.height(fromTop: 0)
        }
    }

}

public class CSButtonBarPagerTabStripViewController: ButtonBarPagerTabStripViewController {

    var parentController: CSXLButtonBarPagerControllerNew!

    func construct(_ parent: CSXLButtonBarPagerControllerNew) -> Self {
        self.parentController = parent
        return self
    }

    public override func viewControllers(
            for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] { parentController.controllers }

    override open func updateContent() { //TODO CHECK IF STILL ISSUE ON IPHONE X AND ADD EXPLANATION COMMENT
        super.updateContent()
        for (index, childController) in parentController.controllers.enumerated() {
            childController.view.frame = CGRect(x: offsetForChild(at: index) + view.safeAreaInsets.left,
                    y: 0, width: view.bounds.width - (view.safeAreaInsets.left + view.safeAreaInsets.right),
                    height: containerView.bounds.height)
        }
    }
}
