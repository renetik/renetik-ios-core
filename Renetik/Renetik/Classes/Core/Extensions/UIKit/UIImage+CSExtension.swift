//
// Created by Rene Dohan on 9/22/19.
//

import UIKit
import RenetikObjc

public extension UIImage {

    public convenience init(_ fileName: String) {
        self.init(named: fileName)!
    }

    var template: UIImage { withRenderingMode(.alwaysTemplate) }

}