//
// Created by Rene on 2026-05-25.
// Copyright (c) 2026 Renetik Software. All rights reserved.
//

import UIKit

open class CSCard: CSView {
    private var shadowElevations = [UInt: CGFloat]()
    private var shadowColors = [UInt: UIColor]()
    private var borderWidths = [UInt: CGFloat]()
    private var borderColors = [UInt: UIColor]()
    private var touchDownActions = [Func]()
    private var touchUpActions = [Func]()
    private var touchStartPoint: CGPoint?
    private var isTouchCancelled = false
    private var isCardHighlighted = false

    open var isInteractable = false
    open var enableRippleBehavior = false
    open var isSelected = false {
        didSet { updateStyle() }
    }

    open var state: UIControl.State {
        var result = UIControl.State.normal
        if isSelected { result.insert(.selected) }
        if isCardHighlighted { result.insert(.highlighted) }
        return result
    }

    open var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            updateShadowPath()
        }
    }

    @discardableResult
    override open func construct() -> Self {
        super.construct()
        clipsToBounds = false
        layer.masksToBounds = false
        layer.cornerRadius = 4
        backgroundColor = .white
        setShadowElevation(1, for: .normal)
        setShadowElevation(8, for: .highlighted)
        setShadowColor(.black, for: .normal)
        return self
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        updateShadowPath()
    }

    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let result = super.hitTest(point, with: event)
        if !isInteractable, result === self { return nil }
        return result
    }

    @discardableResult
    @objc override open func onClick(_ block: @escaping Func) -> Self {
        onTouchUp(block)
    }

    @discardableResult
    @objc override open func onTap(_ block: @escaping Func) -> Self {
        onTouchUp(block)
    }

    @discardableResult
    @objc open func onTouchDown(_ block: @escaping Func) -> Self {
        isInteractable = true
        touchDownActions.append(block)
        return self
    }

    @discardableResult
    @objc open func onTouchUp(_ block: @escaping Func) -> Self {
        isInteractable = true
        touchUpActions.append(block)
        return self
    }

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard isInteractable, let touch = touches.first else { return }
        touchStartPoint = touch.location(in: self)
        isTouchCancelled = false
        setCardHighlighted(true)
        touchDownActions.forEach { $0() }
    }

    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard isInteractable, let touch = touches.first, let start = touchStartPoint else { return }
        let location = touch.location(in: self)
        let distance = hypot(location.x - start.x, location.y - start.y)
        isTouchCancelled = distance > 10 || !bounds.insetBy(dx: -10, dy: -10).contains(location)
        if isTouchCancelled { setCardHighlighted(false) }
    }

    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        defer { resetTouch() }
        guard isInteractable, let touch = touches.first else { return }
        let location = touch.location(in: self)
        if !isTouchCancelled, bounds.contains(location) {
            touchUpActions.forEach { $0() }
        }
    }

    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        resetTouch()
    }

    open func setShadowElevation(_ shadowElevation: CGFloat, for state: UIControl.State) {
        shadowElevations[state.rawValue] = shadowElevation
        updateStyle()
    }

    open func shadowElevation(for state: UIControl.State) -> CGFloat {
        value(shadowElevations, for: state) ?? 0
    }

    open func setShadowColor(_ shadowColor: UIColor?, for state: UIControl.State) {
        shadowColors[state.rawValue] = shadowColor
        updateStyle()
    }

    open func shadowColor(for state: UIControl.State) -> UIColor? {
        value(shadowColors, for: state)
    }

    open func setBorderWidth(_ borderWidth: CGFloat, for state: UIControl.State) {
        borderWidths[state.rawValue] = borderWidth
        updateStyle()
    }

    open func borderWidth(for state: UIControl.State) -> CGFloat {
        value(borderWidths, for: state) ?? 0
    }

    open func setBorderColor(_ borderColor: UIColor?, for state: UIControl.State) {
        borderColors[state.rawValue] = borderColor
        updateStyle()
    }

    open func borderColor(for state: UIControl.State) -> UIColor? {
        value(borderColors, for: state)
    }

    private func resetTouch() {
        touchStartPoint = nil
        isTouchCancelled = false
        setCardHighlighted(false)
    }

    private func setCardHighlighted(_ highlighted: Bool) {
        if isCardHighlighted == highlighted { return }
        isCardHighlighted = highlighted
        UIView.animate(withDuration: highlighted ? 0.08 : 0.16, delay: 0,
                       options: [.allowUserInteraction, .beginFromCurrentState],
                       animations: { self.alpha = highlighted ? 0.7 : 1 })
        updateStyle()
    }

    private func updateStyle() {
        let elevation = shadowElevation(for: state)
        layer.shadowColor = (shadowColor(for: state) ?? .black).cgColor
        layer.shadowOpacity = elevation > 0 ? Float(min(0.14 + elevation * 0.015, 0.28)) : 0
        layer.shadowRadius = max(elevation, 0)
        layer.shadowOffset = CGSize(width: 0, height: max(elevation / 2, 0))
        layer.borderWidth = borderWidth(for: state)
        layer.borderColor = borderColor(for: state)?.cgColor
        updateShadowPath()
    }

    private func updateShadowPath() {
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds, cornerRadius: layer.cornerRadius
        ).cgPath
    }

    private func value<T>(_ values: [UInt: T], for state: UIControl.State) -> T? {
        values[state.rawValue] ?? values[UIControl.State.normal.rawValue]
    }
}
