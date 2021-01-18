//
// Created by Rene Dohan on 12/19/19.
//

import UIKit
import Renetik
import RenetikObjc

open class CSViewController: UIViewController {
    open func view() -> UIView { view }

    public let eventOrientationChanging: CSEvent<Void> = event()
    public let eventOrientationChanged: CSEvent<Void> = event()
    public let eventDismissing: CSEvent<Void> = event()
    public let eventDidAppear: CSEvent<Void> = event()
    public let eventDidLayoutFirstTime: CSEvent<Void> = event()
    public let eventWillAppearFirstTime: CSEvent<Void> = event()
    public let eventDidAppearFirstTime: CSEvent<Void> = event()

    public private(set) var isAppearing = false
    private var isShowingFirstTime = false
    public var isShowing = false { didSet { if isShowing != oldValue { onShowingChanged() } } }
    public var isVisible: Bool { isAppearing && isShowing }
    public private(set) var isDestroyed = false

    private var isDidLayoutSubviews = false
    private var isOnViewWillAppearFirstTime = false
    private var isOnViewDidAppearFirstTime = false
    private var notificationCenterObservers: [NSObjectProtocol] = []
    private var eventRegistrations = [CSEventRegistration]()
    private var isShouldAutorotate: Bool? = nil
    private let layoutFunctions: CSEvent<Void> = event()
    public private(set) var controllerInNavigation: UIViewController?
    private(set) var parentController: UIViewController? {
        didSet {
            (parentController as? CSViewController)
                    .notNil { self.register(event: $0.eventDismissing.listenOnce(function: onViewDismissing)) }
        }
    }
    private var _view: UIView?

    @discardableResult
    open func construct(_ parent: UIViewController, _ view: UIView) -> Self {
        parentController = parent
        _view = view
        return self
    }

    @discardableResult
    open func construct(_ parent: UIViewController) -> Self {
        parentController = parent
        return self
    }

    @discardableResult
    open func construct(_ view: UIView) -> Self {
        _view = view
        return self
    }

    @discardableResult
    public func asViewLess() -> Self {
        later {
            self.parentController!.showChild(controller: self)
            self.view.size(1).isUserInteractionEnabled = false
        }
        isShowing = true
        return self
    }

    open override func loadView() { view = _view ?? CSView.construct(defaultSize: true) }

    override open func viewDidLoad() {
        super.viewDidLoad()
        onViewDidLoad()
    }

    open func onViewDidLoad() {}

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateControllerInNavigation()
        onViewWillAppear()
        if !isOnViewWillAppearFirstTime {
            isOnViewWillAppearFirstTime = true
            onViewWillAppearFirstTime()
        } else {
            view.setNeedsLayout()
            onViewWillAppearFromPresentedController()
        }
    }

    open func onViewWillAppear() {}

    open func onViewWillAppearFirstTime() { eventWillAppearFirstTime.fire() }

    open func onViewWillAppearFromPresentedController() {}

    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateControllerInNavigation()
        if !isDidLayoutSubviews {
            isDidLayoutSubviews = true
            onViewDidLayoutFirstTime()
            onCreateLayout()
            onLayoutCreated()
            eventDidLayoutFirstTime.fire()
        } else {
            onUpdateLayout()
        }
        // We need to call view.layoutSubviews() so view layout functions if any are called,
        // because view.layoutSubviews() was already called before viewDidLayoutSubviews
        view.layoutSubviews()
        runLayoutFunctions()
        onViewDidLayout()
    }

    open func onViewDidLayoutFirstTime() {}

    open func onCreateLayout() {}

    open func onLayoutCreated() {}

    open func onUpdateLayout() {}

    open func onViewDidLayout() {}

    override open func viewDidAppear(_ animated: Bool) {
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

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onViewWillDisappear()
        //    if (self.navigationController.previous == self.controllerInNavigation) self.onViewPushedOver;
    }

    open func onViewWillDisappear() {}

    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if !isAppearing { return }
        isAppearing = false
        onViewDidDisappear()
        if let controllerInNavigation = controllerInNavigation {
            if isMovingFromParent == true && controllerInNavigation.parent == nil {
                onViewDismissing()
            } else if navigation.previous == controllerInNavigation {
                onViewPushedOver()
            }
        }
    }

    override open func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
//        if parent.isNil {
//            logInfo("didMove(toParent:nil \(self) controllerInNavigation:\(controllerInNavigation) isAppearing:\(isAppearing) isShowing:\(isShowing)")
//        }
    }

    open func onViewDidDisappear() {}

    open func onViewPushedOver() {
    }

    open func onViewDismissing() {
        eventRegistrations.each { $0.cancel() }
        notificationCenterObservers.each { NotificationCenter.remove(observer: $0) }
        eventDismissing.fire()
        isDestroyed = true
    }

    private func onShowingChanged() {
        onViewVisibilityChanged(isShowing)
        if isShowing { onViewShowing() } else { onViewHiding() }
    }

    open func onViewVisibilityChanged(_ visible: Bool) {}

    open func onViewShowing() {
        if !isShowingFirstTime { onViewShowingFirstTime(); isShowingFirstTime = true }
    }

    open func onViewShowingFirstTime() {}

    open func onViewHiding() {}

    override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        eventOrientationChanging.fire()
        onViewWillTransition(to: size, coordinator)
        coordinator.onCompletion { context in
            self.onViewDidTransition(to: size, context)
            self.eventOrientationChanged.fire()
        }
    }

    open func onViewWillTransition(to size: CGSize, _ coordinator: UIViewControllerTransitionCoordinator) {}

    open func onViewDidTransition(to size: CGSize, _ context: UIViewControllerTransitionCoordinatorContext) {}

    public func observe(notification name: NSNotification.Name, callback: @escaping (Notification) -> Void) {
        notificationCenterObservers.add(NotificationCenter.add(observer: name, using: callback))
    }

    @discardableResult
    public func register<EventRegistration: CSEventRegistration>(event registration: EventRegistration) -> EventRegistration {
        eventRegistrations.add(registration); return registration
    }

    public func cancel<T>(event registration: CSEventListener<T>) {
        eventRegistrations.remove(registration)?.cancel()
    }

    override open var shouldAutorotate: Bool {
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

    public func layout(function: @escaping Func) {
        layoutFunctions.listen(function: function)
        function()
    }

    @discardableResult
    public func layout<View: UIView>(_ view: View, function: @escaping (View) -> Void) -> View {
        layoutFunctions.listen { function(view) }
        function(view)
        return view
    }

    public func runLayoutFunctions() {
        layoutFunctions.fire()
    }

    func updateControllerInNavigation() {
        if controllerInNavigation.isNil { controllerInNavigation = findControllerInNavigation() }
    }

    @discardableResult
    public func show(in parent: UIViewController) -> Self {
        let transition = CATransition()
        transition.duration = 0.15
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .moveIn
        transition.subtype = .fromBottom
        view.layer.add(transition, forKey: nil)
        parent.showChild(controller: self).view.matchParent()
        return self
    }

    @discardableResult
    open func hideIn() -> Self {
        isShowing = false
        UIView.animate(withDuration: 0.5,
                animations: { self.view.bottom = -5 },
                completion: { finished in self.parent!.dismissChild(controller: self) })
        return self
    }
}
