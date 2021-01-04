//
// Created by Rene Dohan on 12/18/19.
//

import BlocksKit
import Renetik

public extension UIBarButtonItem {

    class var flexSpaceItem: UIBarButtonItem {
        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }

    class var fixedSpaceItem: UIBarButtonItem {
        UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
    }

    class func space(_ width: CGFloat = 15) -> UIBarButtonItem { fixedSpaceItem.width(width) }

    convenience init(image: UIImage, onClick: ArgFunc<UIBarButtonItem>? = nil) {
        self.init()
        if let action = onClick {
            bk_init(with: image, style: UIBarButtonItem.Style.plain, handler: { _ in action(self) })
        } else {
            self.init(image: image, style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        }
    }

    convenience init(image: UIImage, onClick: Func? = nil) {
        self.init(image: image, onClick: { _ in onClick?() })
    }

    convenience init(view: UIView, onClick: ArgFunc<UIBarButtonItem>? = nil) {
        self.init(customView: view)
        if let action = onClick { view.onClick { action(self) } }
    }

    convenience init(view: UIView, onClick: @escaping Func) {
        self.init(customView: view)
        view.onClick { onClick() }
    }

    convenience init(item: UIBarButtonItem.SystemItem, onClick: ((_ sender: UIBarButtonItem) -> Void)? = nil) {
        self.init()
        if let action = onClick {
            bk_init(with: item, handler: { action($0 as! UIBarButtonItem) })
        } else {
            self.init(barButtonSystemItem: item, target: nil, action: nil)
        }
    }

    convenience init(title: String, onClick: ((_ sender: UIBarButtonItem) -> Void)? = nil) {
        self.init()
        if let action = onClick {
            bk_init(withTitle: title, style: UIBarButtonItem.Style.plain,
                    handler: { action($0 as! UIBarButtonItem) })
        } else {
            self.init(title: title, style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        }
    }

    func width(_ value: CGFloat) -> Self { invoke { width = value } }
}