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

    func scale(width: CGFloat) -> UIImage {
        let oldWidth = size.width
        let scaleFactor = width / oldWidth
        return scale(width: oldWidth * scaleFactor, height: size.height * scaleFactor)
    }

    func scale(height: CGFloat) -> UIImage {
        let oldHeight = size.height
        let scaleFactor = height / oldHeight
        return scale(width: size.width * scaleFactor, height: oldHeight * scaleFactor)
    }

    func scale(width newWidth: CGFloat, height newHeight: CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        draw(in: CGRect(width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }


}