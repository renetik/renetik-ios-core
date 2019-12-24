//
//  File.swift
//  Renetik
//
//  Created by Rene Dohan on 3/9/19.
//

import UIKit

public extension UIButton {
    @objc public func alignContent(_ alignment: ContentHorizontalAlignment) -> Self {
        contentHorizontalAlignment = alignment
        return self
    }
}
