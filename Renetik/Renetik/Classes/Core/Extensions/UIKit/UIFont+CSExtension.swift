//
//  UIFont+CSExtension.swift
//  Renetik
//
//  Created by Rene Dohan on 3/6/19.
//

import UIKit

public extension UIFont {
    func withTraits(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        UIFont(descriptor: fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits))!, size: 0)
    }

    func bold() -> UIFont { withTraits(.traitBold) }

    func normal() -> UIFont { withTraits() }

    func italic() -> UIFont { withTraits(.traitItalic) }

    func boldItalic() -> UIFont { withTraits(.traitBold, .traitItalic) }
}
