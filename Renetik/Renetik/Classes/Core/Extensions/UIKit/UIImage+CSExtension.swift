//
// Created by Rene Dohan on 9/22/19.
//

import UIKit

extension UIImage {
    public convenience init(_ fileName: String) {
        self.init(named: fileName)!
    }
}