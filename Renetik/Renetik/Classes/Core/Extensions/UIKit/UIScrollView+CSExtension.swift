//
//  UIScrollView+CSExtension.swift
//  Renetik
//
//  Created by Rene Dohan on 3/6/19.
//

import UIKit

@objc public extension UIScrollView {
    static let scrollStateInaccuracy: CGFloat = 15

    @objc public var isAtTop: Bool {
        return contentOffset.y <= verticalOffsetForTop
    }

    @objc public var isAtBottom: Bool {
//        let bottomEdge = contentOffset.y + height
//        return bottomEdge >= contentSize.height
        return contentOffset.y >= verticalOffsetForBottom
    }

    @objc public var verticalOffsetForTop: CGFloat {
        let topInset = contentInset.top
        return -topInset
    }

    @objc public var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset.rounded()
    }
}
