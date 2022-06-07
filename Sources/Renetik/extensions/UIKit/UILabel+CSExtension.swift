public extension UILabel {
    @discardableResult
    func text(color: UIColor) -> Self { textColor = color; return self }

    @discardableResult
    func text(align: NSTextAlignment) -> Self { textAlignment = align; return self }

    @discardableResult
    func text(break mode: NSLineBreakMode) -> Self { lineBreakMode = mode; return self }

    @discardableResult
    func text(lines: Int) -> Self { numberOfLines = lines; return self }
}

extension UILabel: CSHasTextProtocol {
    public func text() -> String? { text }

    public func text(_ text: String?) { self.text = text }
}

extension UILabel: CSHasFontProtocol {
    public func font() -> UIFont? { font }

    public func font(_ font: UIFont?) { self.font = font }
}
