//
//  Renetik
//
//  Created by Rene Dohan on 7/8/19.
//

import UIKit

@objc public extension UITabBar {
    @objc public var selectedItemIndex: Int {
        if selectedItem.notNil {
            return items!.firstIndex(of: selectedItem!)!
        }
        return -1
    }

}
