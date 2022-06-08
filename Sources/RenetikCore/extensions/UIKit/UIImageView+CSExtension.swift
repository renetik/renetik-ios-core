public extension UIImageView {
    @discardableResult
    func roundImageCorners(_ radius: Int = 5) -> Self {
        if let image = image {
            let boundsScale = bounds.size.width / bounds.size.height
            let imageScale = image.size.width / image.size.height
            var drawingRect = bounds
            if boundsScale > imageScale {
                drawingRect.size.width = drawingRect.size.height * imageScale
                drawingRect.origin.x = (bounds.size.width - drawingRect.size.width) / 2
            }
            else {
                drawingRect.size.height = drawingRect.size.width / imageScale
                drawingRect.origin.y = (bounds.size.height - drawingRect.size.height) / 2
            }
            let path = UIBezierPath(roundedRect: drawingRect, cornerRadius: CGFloat(radius))
            layer.mask = CAShapeLayer().also { $0.path = path.cgPath }
            layer.masksToBounds = true
            clipsToBounds = true
        }
        return self
    }

}

extension UIImageView: CSHasImageProtocol {
    public func image() -> UIImage? { image }

    public func image(_ image: UIImage?) { self.image = image }
}
