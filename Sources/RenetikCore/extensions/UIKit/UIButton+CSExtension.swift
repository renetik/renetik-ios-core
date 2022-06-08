public extension UIButton {
    @discardableResult
    func alignContent(_ alignment: ContentHorizontalAlignment) -> Self {
        contentHorizontalAlignment = alignment
        return self
    }
    
    @discardableResult
    override func aspectFit() -> Self {
        imageView?.aspectFit()
        return self
    }
    
    @discardableResult
    override func aspectFill() -> Self {
        imageView?.aspectFill()
        return self
    }
}

extension UIButton: CSHasTextProtocol {
    public func text() -> String? { title(for: .normal) }
    
    public func text(_ text: String?) { setTitle(text, for: .normal) }
}

extension UIButton: CSHasFontProtocol {
    public func font() -> UIFont? { titleLabel?.font }
    
    public func font(_ font: UIFont?) { titleLabel?.font = font }
}

extension UIButton: CSHasImageProtocol {
    public func image() -> UIImage? { image(for: .normal) }
    
    public func image(_ image: UIImage?) { setImage(image, for: .normal) }
}

extension UIButton: CSHasAttributedTextProtocol {
    public func attributedText() -> NSAttributedString? { attributedTitle(for: .normal) }
    
    public func attributed(text: NSAttributedString?) { setAttributedTitle(text, for: .normal) }
}

extension UIButton: CSHasTextColorProtocol {
    public func textColor() -> UIColor? { titleColor(for: .normal) }
    
    @discardableResult
    public func text(color: UIColor?) -> Self { setTitleColor(color, for: .normal); return self }
}
