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
        sd_imageIndicator = SDWebImageProgressIndicator.default
        sd_setImage(with: url, placeholderImage: nil, options: .retryFailed, progress: nil,
                completed: { image, error, cacheType, imageURL in error.isNil { onSuccess?(self) } })
        return self
    }

    @discardableResult
    public func image(url: String, onSuccess: ((UIImageView) -> Void)? = nil) -> UIImageView {
        URL(string: url).notNil { image(url: $0, onSuccess: onSuccess) }
                .elseDo { "Url for image was invalid: \(url)" }
        return self
    }
}