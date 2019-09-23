//
// Created by Rene Dohan on 9/22/19.
//

import Foundation

extension UITabBarItem {
    public convenience init(title: String, image: UIImage?) {
        self.init(title: title, image: image, tag: 0)
    }
}