//
// Created by Rene Dohan on 12/23/19.
//

import UIKit

public extension UITextInput {
    var text: String {
        get {
            textRange(from: beginningOfDocument, to: endOfDocument)?.ret { range in
                text(in: range) ?? ""
            } ?? ""
        }
        set(value) {
            textRange(from: beginningOfDocument, to: endOfDocument)?.ret { range in
                replace(range, withText: value)
            }
        }
    }
}
