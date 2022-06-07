//
// Created by Rene Dohan on 3/4/20.
//

import UIKit

public extension UISegmentedControl {
    class var defaultHeight: CGFloat { 28 }

    @discardableResult
    func selected(index: Int) -> Self { self.selectedIndex = index; return self }

    var selectedIndex: Int {
        get { selectedSegmentIndex }
        set { selectedSegmentIndex = newValue }
    }

    var selectedTitle: String? {
        selectedSegmentIndex != UISegmentedControl.noSegment ?
                titleForSegment(at: selectedSegmentIndex) : nil
    }


}
