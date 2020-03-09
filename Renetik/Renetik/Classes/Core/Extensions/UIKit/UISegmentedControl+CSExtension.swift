//
// Created by Rene Dohan on 3/4/20.
//

import Foundation
import UIKit

public extension UISegmentedControl {
    class var defaultHeight: CGFloat { 28 }

    func selected(index: Int) -> Self { invoke { self.selectedSegmentIndex = index } }
}