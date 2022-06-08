//
// Created by Rene Dohan on 3/12/20.
//

import UIKit

public extension UIColor {
    static let tint: UIColor = UIButton(type: .system).tintColor

    func add(alpha: CGFloat) -> UIColor { withAlphaComponent(alpha) }

    static var random : UIColor {
        UIColor(red: .randomZeroToOne(), green: .randomZeroToOne(), blue: .randomZeroToOne(), alpha: 1.0)
    }
}