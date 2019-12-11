//
//  CSNotification.swift
//  Renetik
//
//  Created by Rene Dohan on 3/15/19.
//

import RenetikObjc
import RMessage
import UIKit

public extension UIViewController {
    public func toast(_ title: String) { CSNotification().title(title).show() }
}

public class CSNotification: NSObject {
    @objc public var title: String?
    @objc public var subtitle: String?
    @objc public var icon: UIImage?
    @objc public var actionTitle: String?
    @objc public var actionOnClick: (() -> Void)?
    @objc public var dismissable = true
    private var position = RMessagePosition.top
    private var type = RMessageType.normal
    private var duration = RMessageDuration.automatic
    private var time: TimeInterval?

    public override init() {
    }

    public init(_ title: String) {
        self.title = title
    }

    @objc public func bottom() -> Self {
        position = .bottom
        return self
    }

    @objc public func top() -> Self {
        position = .top
        return self
    }

    @objc public func error() -> Self {
        type = RMessageType.error
        return self
    }

    @objc public func warning() -> Self {
        type = RMessageType.warning
        return self
    }

    @objc public func success() -> Self {
        type = RMessageType.success
        return self
    }

    @objc public func navBar() -> Self {
        position = .navBarOverlay
        return self
    }

    @objc public func title(_ title: String) -> Self {
        self.title = title
        return self
    }

    @objc public func title(_ title: String, show parent: UIViewController) -> Self {
        self.title = title
        show(parent)
        return self
    }

    @objc public func icon(_ icon: UIImage) -> Self {
        self.icon = icon
        return self
    }

    @objc public func subtitle(_ subtitle: String?) -> Self {
        self.subtitle = subtitle
        return self
    }

    @objc public func action(_ title: String?, _ onClick: @escaping () -> Void) -> Self {
        actionTitle = title
        actionOnClick = onClick
        dismissable = false
        return self
    }

    @objc public func dismissable(_ dismissable: Bool) -> Self {
        self.dismissable = dismissable
        return self
    }

    @objc public func hanging() -> Self {
        dismissable = false
        duration = .endless
        return self
    }

    @objc public func time(_ time: TimeInterval) -> Self {
        self.time = time
        return self
    }

    @discardableResult
    @objc public func show() -> Self {
        show(navigation.last!)
    }

    @discardableResult
    @objc public func show(_ parent: UIViewController?) -> Self {
        RMessage.showNotification(
                in: parent, title: title, subtitle: subtitle, iconImage: icon,
                type: type, customTypeName: nil,
                duration: (time.notNil ? time! : TimeInterval(duration.rawValue)),
                callback: nil, presentingCompletion: nil, dismissCompletion: nil,
                buttonTitle: actionTitle, buttonCallback: actionOnClick,
                at: position, canBeDismissedByUser: dismissable)
        return self
    }

    @objc public class func dismissActive() {
        RMessage.dismissActiveNotification()
    }
}
