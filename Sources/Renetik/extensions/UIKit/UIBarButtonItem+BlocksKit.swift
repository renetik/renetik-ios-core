import UIKit

public extension UIBarButtonItem {

    convenience init(image: UIImage, onClick: Func? = nil) {
        self.init(image: image, onClick: { _ in onClick?() })
    }

    convenience init(image: UIImage, onClick: ArgFunc<UIBarButtonItem>? = nil) {
        self.init()
        if let action = onClick {
            self.init(image: image, style: UIBarButtonItem.Style.plain, target: self, action: #selector(handleAction))
            associatedDictionary["action"] = action
        }
        else {
            self.init(image: image, style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        }
    }

    convenience init(item: UIBarButtonItem.SystemItem, onClick: ((_ sender: UIBarButtonItem) -> Void)? = nil) {
        self.init()
        if let action = onClick {
            self.init(barButtonSystemItem: item, target: self, action: #selector(handleAction))
            associatedDictionary["action"] = action
        }
        else {
            self.init(barButtonSystemItem: item, target: nil, action: nil)
        }
    }

    convenience init(title: String, onClick: ((_ sender: UIBarButtonItem) -> Void)? = nil) {
        self.init()
        if let action = onClick {
            self.init(title: title, style: .plain, target: self, action: #selector(handleAction))
            associatedDictionary["action"] = action
        }
        else {
            self.init(title: title, style: .plain, target: nil, action: nil)
        }
    }

    convenience init(image: UIImage, style: UIBarButtonItem.Style, onClick: ((_ sender: UIBarButtonItem) -> Void)? = nil) {
        self.init()
        if let action = onClick {
            self.init(image: image, style: style, target: self, action: #selector(handleAction))
            associatedDictionary["action"] = action
        }
        else {
            self.init(image: image, style: style, target: nil, action: nil)
        }
    }

    @objc func handleAction(sender: UIBarButtonItem) {
        (associatedDictionary["test"] as? ArgFunc<UIBarButtonItem>)?(sender)
    }
}
