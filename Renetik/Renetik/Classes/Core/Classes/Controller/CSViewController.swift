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
    public let eventWillAppear: CSEvent<Void> = event()
    public let eventWillAppearFirstTime: CSEvent<Void> = event()
    public let eventDidAppearFirstTime: CSEvent<Void> = event()

    public private(set) var isAppearing = false
    private var isShowingFirstTime = false
    public var isShowing = false { didSet { if isShowing != oldValue { onShowingChanged() } } }
    public var isVisible: Bool { isAppearing && isShowing }
    public private(set) var isDismissed = false

    private var isDidLayoutSubviews = false
    private var isOnViewWillAppearFirstTime = false
    private var isOnViewDidAppearFirstTime = false
    private var notificationCenterObservers = CSArray<NSObjectProtocol>()
    private var eventRegistrations = CSArray<CSEventRegistration>()
    private var isShouldAutorotate: Bool? = nil
    private let layoutFunctions: CSEvent<Void> = event()
    public private(set) var controllerInNavigation: UIViewController?
    public private(set) var parentController: UIViewController? {
        didSet {
            (parentController as? CSViewController)
                    .notNil { self.register(event: $0.eventDismissing.listenOnce(function: onViewDismissing)) }
        }
    }

//    @discardableResult
//    open func construct(_ parent: UIViewController, _ view: UIView) -> Self {
//        parentController = parent
//        _view = view
//        return self
//    }

    @discardableResult // TODO: change to class method
    open func construct(_ parent: UIViewController) -> Self {
        parentController = parent
        return self
    }

//    @discardableResult
//    open func construct(_ view: UIView) -> Self {
//        _view = view
//        return self
//    }

    @discardableResult
    public func asViewLess() -> Self {
        later {
            self.parentController!.add(controller: self)
            self.view.size(1).isUserInteractionEnabled = false
        }
        isShowing = true
        return self
    }

    open override func loadView() { view = CSView.construct(defaultSize: true) }

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
            onViewWillAppearFromPresentedController()
        }
        view.setNeedsLayout()
    }

    open func onViewWillAppear() { eventWillAppear.fire() }

    public func onViewWillAppearUpdated(function: @escaping () -> Void) {
        function()
        eventWillAppear.listen(function: function)
    }

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
        // view.layoutSubviews() was already called before viewDidLayoutSubviews so calling again
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
        if parent == nil && (self as? CSPagerPage).isNil {
            onViewDismissing()
        } else {
            if let controllerInNavigation = controllerInNavigation {
                if isMovingFromParent == true && controllerInNavigation.parent == nil {
                    onViewDismissing()
                } else if navigation.previous == controllerInNavigation {
                    onViewPushedOver()
                }
            }
        }
    }

    override open func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
    }

    override open func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
    }

    open func onViewDidDisappear() {}

    open func onViewPushedOver() {
    }

    open func onViewDismissing() {
        if isDismissed { return }
        eventRegistrations.each { $0.cancel() }.clear()
        notificationCenterObservers.each { NotificationCenter.remove(observer: $0) }.clear()
        eventDismissing.fire()
        isDismissed = true
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
        parent.add(controller: self).view.matchParent()
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
