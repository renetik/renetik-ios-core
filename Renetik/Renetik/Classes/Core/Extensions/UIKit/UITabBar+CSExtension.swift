//
//  Renetik
//
//  Created by Rene Dohan on 7/8/19.
//

import UIKit
import Renetik
import RenetikObjc

public extension UITabBar {

//    static var portraitHeight: CGFloat?
//    static var landscapeHeight: CGFloat?
//
//    class var defaultHeight: CGFloat {
//        if UIScreen.isPortrait {
//            if portraitHeight.isNil {
//                portraitHeight = UIToolbar().resizeToFit().height
//            }
//            return portraitHeight!
//        } else {
//            if landscapeHeight.isNil {
//                landscapeHeight = UIToolbar().resizeToFit().height
//            }
//            return landscapeHeight!
//        }
//    }

    public var selectedItemIndex: Int {
        get {
            if selectedItem.notNil {
                return items!.firstIndex(of: selectedItem!)!
            }
            return -1
        }
        set {
            selectedItem = items![newValue]
        }
    }
}
