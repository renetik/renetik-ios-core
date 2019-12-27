//
// Created by Rene Dohan on 12/23/19.
//

import Foundation
import UIKit

public extension UITextInput {
    public var text: String {
        get { text(in: textRange(from: beginningOfDocument, to: endOfDocument)!) ?? "" }
        set(value) { replace(textRange(from: beginningOfDocument, to: endOfDocument)!, withText: value) }
    }
}