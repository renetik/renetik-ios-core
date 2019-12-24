//
// Created by Rene on 2018-11-22.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

import UIKit

public extension UIView {
    public var availableHeight: CGFloat { height - navigation.navigationBar.bottom }
}