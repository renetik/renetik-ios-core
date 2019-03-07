//
//  UIFont+CSExtension.swift
//  Renetik
//
//  Created by Rene Dohan on 3/6/19.
//

import UIKit

@objc public extension UIFont {
    @nonobjc public func withTraits(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
		let descriptor = fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits))!
        return UIFont(descriptor: descriptor, size: 0)
    }

    @objc public func bold() -> UIFont {
		return withTraits(.traitBold)
    }
	
	@objc public func normal() -> UIFont {
		return withTraits()
	}

    @objc public func italic() -> UIFont {
		return withTraits(.traitItalic)
    }

    @objc public func boldItalic() -> UIFont {
		return withTraits(.traitBold, .traitItalic)
    }
}
