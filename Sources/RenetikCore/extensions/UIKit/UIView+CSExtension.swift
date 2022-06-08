public protocol CSHasConstruct: AnyObject {
    func construct() -> Self
}

extension UIView{

    @discardableResult
    @objc open func onClick(_ block: @escaping Func) -> Self {
        onTap { block() }
        return self
    }
    
    @discardableResult
    @objc open func onTap(_ block: @escaping Func) -> Self {
        interaction(enabled: true)
        addTapRecognizer(numberOfTouches: 1, numberOfTaps: 1) { block() }
        return self
    }
    
    @discardableResult
    @objc open func aspectFit() -> Self { contentMode = .scaleAspectFit; return self }
    
    @discardableResult
    @objc open func aspectFill() -> Self { contentMode = .scaleAspectFill; return self }
}

public extension UIView {
    
    @discardableResult
    func onLongPress(_ block: @escaping Func) -> Self {
        isUserInteractionEnabled = true
        addGestureRecognizer(UILongPressGestureRecognizer { block() })
        return self
    }
    
    @discardableResult
    func background(_ color: UIColor) -> Self { invoke { backgroundColor = color } }
    
    @discardableResult
    func background(_ color: UIColor, opacity: CGFloat) -> Self {
        background(color.add(alpha: opacity))
    }
    
    @discardableResult
    func background(color: UIColor, opacity: CGFloat = 1) -> Self {
        background(color.add(alpha: opacity))
    }
    
    @discardableResult
    func interaction(enabled: Bool) -> Self { isUserInteractionEnabled = enabled; return self }
    
    @discardableResult
    func tint(color: UIColor) -> Self { tintColor = color; return self }
    
    @discardableResult
    func rotate(angle: CGFloat) -> Self { transform = CGAffineTransform(rotationAngle: angle); return self }
    
    @discardableResult
    func content(mode: UIView.ContentMode) -> Self { contentMode = mode; return self }
    
    @discardableResult
    func clipsToBounds(_ value: Bool = true) -> Self { clipsToBounds = value; return self }
    
    @discardableResult
    func asCircular() -> Self {
        aspectFill()
        layer.cornerRadius = width / 2
        layer.masksToBounds = true
        clipsToBounds = true
        return self
    }
    
    @discardableResult
    func roundedCorners(width: Int = 5) -> Self {
        layer.cornerRadius = CGFloat(width)
        layer.masksToBounds = true
        clipsToBounds = true
        return self
    }
    
    @discardableResult
    func clipToBounds() -> Self { clipsToBounds = true; return self }
    
    @discardableResult
    func border(width: CGFloat = 1, color: UIColor = .darkGray, radius: CGFloat = 3) -> Self {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.cornerRadius = radius
        layer.masksToBounds = true
        clipsToBounds = true
        return self
    }
    
    func clone() -> Self {
        try! NSKeyedUnarchiver.unarchivedObject(ofClass: Self.self,
                                                from: try! NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false))!
        //        NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! Self
    }
    
    var firstResponder: UIView? {
        for view in subviews {
            if view.isFirstResponder { return view }
            let childFirstResponder = view.firstResponder
            if childFirstResponder.notNil { return childFirstResponder }
        }
        return nil
    }
    
    @discardableResult
    func background(fadeTo color: UIColor) -> Self {
        if backgroundColor == color { return self }
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue = backgroundColor?.cgColor
        animation.toValue = color.cgColor
        animation.duration = .defaultAnimation
        layer.add(animation, forKey: "fadeAnimation")
        backgroundColor = color
        return self
    }
    
    @discardableResult
    func fadeToggle() -> Self { (isVisible && alpha == 1).then { fadeOut() }.elseDo { fadeIn() }; return self }
    
    @discardableResult
    func fadeTo(visible: Bool) -> Self { visible.isTrue { fadeIn() }.elseDo { fadeOut() }; return self }
    
    func fadeIn(duration: TimeInterval = .defaultAnimation, onDone: Func? = nil) {
        if isVisible && alpha == 1 { onDone?(); return }
        show()
        UIView.animate(withDuration: duration, delay: 0,
                       options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState],
                       animations: { [unowned self] in alpha = 1 },
                       completion: { _ in onDone?() })
    }
    
    func fadeOut(duration: TimeInterval = .defaultAnimation, onDone: Func? = nil) {
        if isHidden || alpha == 0 { onDone?(); return }
        UIView.animate(withDuration: duration, delay: 0,
                       options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState],
                       animations: { [unowned self] in alpha = 0 },
                       completion: { [unowned self] isFinished in if isFinished { alpha = 1; hide() }; onDone?() })
    }
    
    @discardableResult
    func background4(dashed color: UIColor, stroke: NSNumber, gap: NSNumber) -> Self {
        clipsToBounds()
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineDashPattern = [stroke, gap]
        
        let path = CGMutablePath()
        let point1 = CGPoint(x: frame.minX, y: bounds.midY)
        let point2 = CGPoint(x: frame.maxX, y: bounds.midY)
        path.addLines(between: [point1, point2])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
        return self
    }
    
    func data(_ value: Any) -> Self {
        associatedDictionary["UIView+CSExtension.model"] = value
        return self
    }
    
    func data() -> Any? { associatedDictionary["UIView+CSExtension.model"] }
    
    func addTapRecognizer(numberOfTouches: Int, numberOfTaps: Int, handler: @escaping Func) {
        let recognizer = UITapGestureRecognizer()
        recognizer.numberOfTouchesRequired = numberOfTouches
        recognizer.numberOfTapsRequired = numberOfTaps
        recognizer.add(action: handler)
        //	[self.gestureRecognizers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        //		if (![obj isKindOfClass:[UITapGestureRecognizer class]]) return;
        //		UITapGestureRecognizer *tap = obj;
        //		BOOL rightTouches = (tap.numberOfTouchesRequired == numberOfTouches);
        //		BOOL rightTaps = (tap.numberOfTapsRequired == numberOfTaps);
        //		if (rightTouches && rightTaps) {
        //			[gesture requireGestureRecognizerToFail:tap];
        //		}
        //	}];
        addGestureRecognizer(recognizer)
    }
    
    @objc var isEmpty: Bool { subviews.isEmpty }
}
