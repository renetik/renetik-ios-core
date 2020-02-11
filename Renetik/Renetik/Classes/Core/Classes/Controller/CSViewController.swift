//
// Created by Rene Dohan on 12/19/19.
//

import UIKit
import Renetik
import RenetikObjc

open class CSViewController: UIViewController {

    public let onOrientationChanging: CSEvent<Void> = event()
    public let onOrientationChanged: CSEvent<Void> = event()
    public let eventDismissing: CSEvent<Void> = event()
    public let eventDidAppear: CSEvent<Void> = event()
    public let eventDidAppearFirstTime: CSEvent<Void> = event()

    public private(set) var isAppearing = false
    public var isShowing = false { didSet { if isShowing != oldValue { onShowingChanged() } } }
    public var isVisible: Bool { self.isAppearing && self.isShowing }

    private var isDidLayoutSubviews = false
    private var isOnViewWillAppearFirstTime = false
    private var isOnViewDidAppearFirstTime = false
    private var notificationCenterObservers: [NSObjectProtocol] = []
    private var eventRegistrations = [CSEventRegistration]()
    private var isShouldAutorotate: Bool? = nil

    @discardableResult
    public func constructAsViewLess(in parent: UIViewController) -> Self {
        doLater {
            parent.showChild(controller: self)
            self.view.matchParent()
            self.view.isUserInteractionEnabled = false
        }
        isShowing = true
        return self
    }

    // We need some size otherwise viewDidLayoutSubviews not called in some cases especially in constructAsViewLess
    override open func loadView() { view = UIControl.withSize(1, 1) }

    override public func viewDidLoad() {
        super.viewDidLoad()
        onViewDidLoad()
    }

    open func onViewDidLoad() {}

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onViewWillAppear()
        if !isOnViewWillAppearFirstTime {
            isOnViewWillAppearFirstTime = true
            onViewWillAppearFirstTime()
        } else {
            onViewWillAppearFromPresentedController()
        }
    }

    open func onViewWillAppear() {}

    open func onViewWillAppearFirstTime() {}

    open func onViewWillAppearFromPresentedController() {}

    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !isDidLayoutSubviews {
            isDidLayoutSubviews = true
            onCreateLayout()
            onLayoutCreated()
        } else {
            onUpdateLayout()
        }
        onViewDidLayout()
    }

    open func onCreateLayout() {}

    open func onLayoutCreated() {}

    open func onUpdateLayout() {}

    open func onViewDidLayout() {}

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isAppearing = true
        onViewDidAppear()
        if !isOnViewDidAppearFirstTime {
            isOnViewDidAppearFirstTime = true
            onViewDidAppearFirstTime()
        } else {
            onViewDidAppearFromPresentedController()
        }
    }

    open func onViewDidAppear() { eventDidAppear.fire() }

    open func onViewDidAppearFirstTime() { eventDidAppearFirstTime.fire() }

    //TODO: this is probably called also in different situations so has wrong name
    open func onViewDidAppearFromPresentedController() {
    }

    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onViewWillDisappear()
        //    if (self.navigationController.previous == self.controllerInNavigation) self.onViewPushedOver;
    }

    open func onViewWillDisappear() {}

    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if !isAppearing { return }
        isAppearing = false
        onViewDidDisappear()
        if controllerInNavigation?.parent == nil { onViewDismissing() }
        if navigationController?.previous == controllerInNavigation { onViewPushedOver() }
    }

    open func onViewDidDisappear() {}

    open func onViewPushedOver() {}

    open func onViewDismissing() { eventDismissing.fire() }

    private func onShowingChanged() {
        onViewVisibilityChanged(isShowing)
        if isShowing { onViewShowing() } else { onViewHiding() }
    }

    open func onViewVisibilityChanged(_ visible: Bool) {}

    open func onViewShowing() {}

    open func onViewHiding() {}

    override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        onOrientationChanging.fire()
        onViewWillTransition(to: size, coordinator)
        coordinator.onCompletion { context in
            self.onViewWillTransition(toSizeCompletion: size, context)
            self.onOrientationChanged.fire()
        }
    }

    open func onViewWillTransition(to size: CGSize, _ coordinator: UIViewControllerTransitionCoordinator) {}

    open func onViewWillTransition(toSizeCompletion size: CGSize,
                                   _ context: UIViewControllerTransitionCoordinatorContext) {}

    public func observe(notification name: NSNotification.Name, callback: @escaping (Notification) -> Void) {
        notificationCenterObservers.add(NotificationCenter.add(observer: name, using: callback))
    }

    @discardableResult
    public func register<T>(event registration: CSEventListener<T>) -> CSEventListener<T> {
        eventRegistrations.add(registration).cast()
    }

    public func cancel<T>(event registration: CSEventListener<T>) {
        eventRegistrations.remove(registration)?.cancel()
    }

    public var isInNavigationController: Bool {
        if controllerInNavigation.notNil {
            return true
        }
        return false
    }

    public var controllerInNavigation: UIViewController? {
        if parent == navigationController { return self }
        var controller: UIViewController? = self
        repeat {
            controller = controller?.parent
        } while controller.notNil && controller?.parent != navigationController
        return controller
    }

    override public var shouldAutorotate: Bool {
        if isShouldAutorotate.notNil { return isShouldAutorotate! }
        return super.shouldAutorotate
    }

    public func clearShouldAutorotate() { isShouldAutorotate = nil }

    override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 12.0, *) {
            if previousTraitCollection?.isDarkMode != isDarkMode { onDisplayChangedTo(darkMode: isDarkMode) }
        }
    }

    open func onDisplayChangedTo(darkMode: Bool) {}
}
