//
//  MDCCard+CSExtension.swift
//  Motorkari
//
//  Created by Rene Dohan on 3/18/19.
//  Copyright © 2019 Renetik Software. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents
import Renetik

extension MDCBaseTextField: CSHasEmptyProtocol {
}

public extension MDCBaseTextField {

    open override func construct() -> Self {
        super.construct()
        interaction(enabled: true)
        clipsToBounds = false
        return self
    }

    var eventClear: CSEvent<Void> { associated("MDCOutlinedTextField+eventClear") { event() } }

    @discardableResult
    @objc override func onClear(_ function: @escaping () -> Void) -> Self {
        eventClear.listen { _ in function() }
        super.onClear(function)
        return self
    }

    @discardableResult
    func with(clear clearImage: UIImage, clearTint: UIColor? = nil, size: CGFloat = 18) -> Self {
        with(clear: UIControl.construct().size(40).also {
            $0.addRipple()
            $0.add(view: CSImageView.construct()) { [unowned self] in
                $0.image = clearImage
                clearTint?.also { tintColor = $0 }
            }.size(size).centered()
        })
    }

    @discardableResult
    func with(clear clearView: UIView) -> Self {
        clearButtonMode = .never
        clearView.onClick { [unowned self] in
            text = nil
            eventClear.fire()
        }
        var trailingViewToRestore: UIView? = nil
        var trailingViewModeToRestore: UITextField.ViewMode? = nil

        func saveStateToRestore() {
            trailingViewToRestore = trailingView
            trailingViewModeToRestore = trailingViewMode
        }

        func restoreState() {
            trailingView = trailingViewToRestore
            trailingViewToRestore = nil
            trailingViewMode = trailingViewModeToRestore!
            trailingViewModeToRestore = nil
        }

        func showClearIcon() {
            trailingView = clearView
            trailingViewMode = .always
        }

        var isClearVisible: Bool { trailingView == clearView }

        func updateClearIcon() {
            if text.isSet {
                if !isClearVisible {
                    saveStateToRestore()
                    showClearIcon()
                }
            }
            else if isClearVisible {
                restoreState()
            }
        }

        updateClearIcon()
        onTextChange { field in updateClearIcon() }
        return self
    }

    @discardableResult
    override func text(color: UIColor) -> Self {
        setTextColor(color, for: .normal)
        setTextColor(color, for: .editing)
        setFloatingLabelColor(color, for: .normal)
        setFloatingLabelColor(color, for: .editing)
        setNormalLabelColor(color, for: .normal)
        setNormalLabelColor(color, for: .editing)
        return self
    }
}

extension MDCBaseTextField: CSHasLabelProtocol {
    public func label() -> String? { label.text }

    @objc open func label(_ text: String?) {
        label.text = text
    }
}