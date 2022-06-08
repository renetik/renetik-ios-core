public extension UIBarButtonItem {

    class var flexSpaceItem: UIBarButtonItem {
        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }

    class var fixedSpaceItem: UIBarButtonItem {
        UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
    }

    class func space(_ width: CGFloat = 15) -> UIBarButtonItem { fixedSpaceItem.width(width) }

    convenience init(view: UIView, onClick: ArgFunc<UIBarButtonItem>? = nil) {
        self.init(customView: view)
        if let action = onClick { view.onClick { action(self) } }
    }

    convenience init(view: UIView, onClick: @escaping Func) {
        self.init(customView: view)
        view.onClick { onClick() }
    }

    func width(_ value: CGFloat) -> Self { invoke { width = value } }
}
