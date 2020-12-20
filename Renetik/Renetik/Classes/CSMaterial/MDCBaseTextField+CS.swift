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
import RenetikObjc

public extension MDCBaseTextField {

    open override func construct() -> Self {
        super.construct()
        interaction(enabled: true)
        clipsToBounds = false
        return self
    }

    @discardableResult
    func hint(text: String) -> Self {
        label.text = text
        placeholder = text
        return self
    }

    var eventClear: CSEvent<Void> {
        associatedDictionary("MDCOutlinedTextField+eventClear", onCreate: { event() })
    }

    @discardableResult
    @objc override func onClear(_ function: @escaping () -> Void) -> Self {
        eventClear.listen { _ in function() }
        super.onClear(function)
        return self
    }

    @discardableResult
    func with(clear clearImage: UIImage, clearTint: UIColor? = nil, size: CGFloat = 18) -> Self {
        with(clear: CSMaterialControl.construct().size(40).also {
            $0.add(view: CSImageView.construct()) {
                $0.image = clearImage
                clearTint?.also { self.tintColor = $0 }
            }.size(size).centered()
        })
    }

    @discardableResult
    func with(clear clearView: UIView) -> Self {
        clearButtonMode = .never
        clearView.onClick { [self] in
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
            } else if isClearVisible {
                restoreState()
            }
        }

        updateClearIcon()
        onTextChange { field in updateClearIcon() }
        return self
    }
}