//
// Created by Rene Dohan on 11/22/20.
//

import Foundation
import UIKit

public protocol CSHasImageProtocol: AnyObject {
    func image() -> UIImage?
    func image(_ font: UIImage?)
}

public extension CSHasImageProtocol {

    var image: UIImage? {
        get { image() }
        set { image(newValue) }
    }

    @discardableResult
    func image(_ image: UIImage) -> Self { self.image = image; return self }

    @discardableResult
    func image(template image: UIImage) -> Self { self.image(image.template) }

    @discardableResult
    func resizableImage(capInsets insets: UIEdgeInsets) -> Self {
        image = image!.resizableImage(withCapInsets: insets); return self
    }

    @discardableResult
    func stretchableImage(leftCapWidth: Int, topCapHeight: Int) -> Self {
        image = image!.stretchableImage(withLeftCapWidth: leftCapWidth, topCapHeight: topCapHeight)
        return self
    }
}
