//
//  CSNotification.swift
//  Renetik
//
//  Created by Rene Dohan on 3/15/19.
//

import Foundation
import UIKit
import RMessage

public extension UIViewController {
    public func toast(_ title: String) { CSNotification().title(title).show(self) }

    public func toast(success title: String) { CSNotification().success().title(title).show(self) }

    public func toast(warning title: String) { CSNotification().warning().title(title).show(self) }

    public func toast(error title: String) { CSNotification().error().title(title).show(self) }
}

public class CSNotification: CSObject {
    public var title: String?
    public var body: String?
    public var icon: UIImage?
    public var actionOnClick: (() -> Void)?
    public var dismissible = true

    private var position: RMessagePosition = .top
    private var type: RMessageSpec = normalSpec
    private var time: TimeInterval = 3
    private static var controller = { RMController() }()

    public override init() {
    }

    public init(_ title: String) {
        self.title = title
    }

    public init(_ title: String, _ body: String) {
        self.title = title
        self.body = body
    }

    public func bottom() -> Self { invoke { position = .bottom } }

    public func top() -> Self {
        position = .top
        return self
    }

    public func error() -> Self {
        type = errorSpec
        return self
    }

    public func warning() -> Self {
        type = warningSpec
        return self
    }

    public func success() -> Self {
        type = successSpec
        return self
    }

    public func navBar() -> Self {
        position = .navBarOverlay
        return self
    }

    public func title(_ title: String) -> Self {
        self.title = title
        return self
    }

    public func title(_ title: String, show parent: UIViewController) -> Self {
        self.title = title
        show(parent)
        return self
    }

    public func icon(_ icon: UIImage) -> Self {
        self.icon = icon
        return self
    }

    public func subtitle(_ subtitle: String?) -> Self {
        self.body = subtitle
        return self
    }

    public func action(onClick: @escaping () -> Void) -> Self {
        actionOnClick = onClick
        dismissible = false
        return self
    }

    public func dismissable(_ dismissable: Bool) -> Self {
        self.dismissible = dismissable
        return self
    }

    public func hanging() -> Self {
        dismissible = false
        return self
    }

    public func time(_ time: TimeInterval) -> Self {
        self.time = time
        return self
    }

    @discardableResult
    public func show() -> Self { show(navigation.last!) }

    @discardableResult
    public func show(_ parent: UIViewController?) -> Self {
        var type = self.type
        type.durationType = dismissible ? .timed : .endless
        type.timeToDismiss = time
        type.iconImage = icon
        Self.controller.showMessage(withSpec: type, atPosition: position, title: title ?? "",
                body: body, viewController: parent, leftView: nil, rightView: nil, backgroundView: nil,
                tapCompletion: actionOnClick, presentCompletion: nil, dismissCompletion: nil)
        return self
    }

    public class func dismissActive() { Self.controller.dismissOnScreenMessage() }
}
