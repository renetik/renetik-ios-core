//
// Created by Rene Dohan on 2/16/20.
//

import Foundation
import UIKit
import RenetikObjc
import XLPagerTabStrip

public typealias CSXLButtonBarPagerChildController = CSMainController & IndicatorInfoProvider

public class CSXLButtonBarPagerController: CSMainController, PagerTabStripIsProgressiveDelegate {

    public let pager = CSButtonBarPagerTabStripViewController()

    fileprivate var controllers: [CSXLButtonBarPagerChildController]!
    private var currentController: CSXLButtonBarPagerChildController { controllers[pager.currentIndex] }

    @discardableResult
    public func construct(by parent: CSMainController, controllers: [CSXLButtonBarPagerChildController]) -> Self {
        super.construct(parent)
        self.controllers = controllers
        parent.showChild(controller: self).view.matchParent()
        showChild(controller: pager.construct(self)).view.matchParent()
        addChildMain(controllers: controllers)
        pager.settings.style.buttonBarHeight.isNil { self.pager.settings.style.buttonBarHeight = 44 }
        return self
    }

    public override func onViewWillAppearFirstTime() {
        super.onViewWillAppearFirstTime()
        updateControllersVisible(at: pager.currentIndex, animated: false)
        pager.delegate = self
    }

    public override func onViewDidAppearFirstTime() {
        super.onViewDidAppearFirstTime()
        pager.reloadPagerTabStripView()
        pager.delegate = self
    }

    public func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int) {
        updateControllersVisible(at: pager.currentIndex, animated: true)
    }

    public func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int,
                                withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
        if indexWasChanged && progressPercentage == 1 { updateControllersVisible(at: pager.currentIndex, animated: false) }
    }

    func updateControllersVisible(at index: Int, animated: Bool) {
        for controller in controllers { controller.isShowing = false }
        currentController.isShowing = true
        updateBarItemsAndMenu(animated: animated)
    }

    public func load(controllers: [CSXLButtonBarPagerChildController]) {
        self.controllers = controllers
        addChildMain(controllers: self.controllers)
        pager.reloadPagerTabStripView()
        updateControllersVisible(at: pager.currentIndex, animated: false)
    }

    public func add(controller: CSXLButtonBarPagerChildController) {
        controllers.add(controller)
        addChildMain(controller: controller)
        pager.reloadPagerTabStripView()
        updateControllersVisible(at: pager.currentIndex, animated: false)
    }

    public override func onViewDidTransition(to size: CGSize,
                                             _ context: UIViewControllerTransitionCoordinatorContext) {
        super.onViewDidTransition(to: size, context)
        self.pager.containerView.scrollTo(page: self.pager.currentIndex, of: self.controllers.count)
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

    public var currentIndex: Int { self.pager.currentIndex }

    @discardableResult
    public func moveToController(index: Int) -> Self { invoke { self.pager.moveToViewController(at: index) } }

    @discardableResult
    public func moveTo(controller: UIViewController) -> Self { invoke { self.pager.moveTo(viewController: controller) } }
}

public class CSButtonBarPagerTabStripViewController: ButtonBarPagerTabStripViewController {

    var parentController: CSXLButtonBarPagerController!

    func construct(_ parent: CSXLButtonBarPagerController) -> Self {
        self.parentController = parent
        return self
    }

    public override func viewControllers(
            for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        parentController.controllers
    }

    // PagerTabStripDelegate delegate was not called by super implementation
    public override func updateIndicator(for viewController: PagerTabStripViewController,
                                         fromIndex: Int, toIndex: Int) {
        super.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex)
        parentController.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex)
    }

    // PagerTabStripIsProgressiveDelegate delegate was not called by super implementation
    public override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int,
                                         withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
        super.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex,
                withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
        parentController.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex,
                withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
    }

    // Fixes overlapping of content by bezels on iphone x and similar
    override open func updateContent() {
        super.updateContent()
        for (index, childController) in parentController.controllers.enumerated() {
            childController.view.frame = CGRect(x: offsetForChild(at: index) + view.safeAreaInsets.left,
                    y: 0, width: view.bounds.width - (view.safeAreaInsets.left + view.safeAreaInsets.right),
                    height: containerView.bounds.height)
        }
    }
}
