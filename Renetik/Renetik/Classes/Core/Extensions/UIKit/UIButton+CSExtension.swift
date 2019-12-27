//
//  File.swift
//  Renetik
//
//  Created by Rene Dohan on 3/9/19.
//

import UIKit
import RenetikObjc

public extension UIButton {
    public func alignContent(_ alignment: ContentHorizontalAlignment) -> Self {
        contentHorizontalAlignment = alignment
        return self
    }

    public var text: String {
        get { title() }
        set(value) { title(value) }
    }
}
