//
//  File.swift
//  Renetik
//
//  Created by Rene Dohan on 2/14/19.
//

import UIKit

public extension UIActivityViewController {
    @discardableResult
    public func source(view: UIView) -> Self {
        popoverPresentationController?.sourceView = view.superview
        popoverPresentationController?.sourceRect = view.frame
        return self
    }

    @discardableResult
    public func source(barItem: UIBarButtonItem) -> Self {
        popoverPresentationController?.barButtonItem = barItem
        return self
    }

    public func present() {
        navigation.last!.present(self, animated: true, completion: nil)
    }
}
