//
// Created by Rene Dohan on 12/23/19.
//

import Foundation
import UIKit
import SDWebImage
import RenetikObjc

public extension UIImageView {

    @discardableResult
    public func image(url: URL, onSuccess: ((UIImageView) -> Void)? = nil) -> UIImageView {
        image(url: url.absoluteString, onSuccess: onSuccess)
    }

    @discardableResult
    public func image(url: String, onSuccess: ((UIImageView) -> Void)? = nil) -> UIImageView {
        sd_imageIndicator = SDWebImageProgressIndicator.default
        sd_setImage(with: URL(url), placeholderImage: nil, options: .retryFailed, progress: nil,
                completed: { image, error, cacheType, imageURL in error.isNil { onSuccess?(self) } })
        return self
    }
}