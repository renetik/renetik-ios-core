//
// Created by Rene Dohan on 12/22/19.
//

import UIKit

public class CSTextField: UITextField {

    public var hideCursor = false

    public var edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    override public func caretRect(for position: UITextPosition) -> CGRect {
        hideCursor ? .zero : super.caretRect(for: position)
    }

    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds.inset(by: edgeInsets))
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.editingRect(forBounds: bounds.inset(by: edgeInsets))
    }
}
