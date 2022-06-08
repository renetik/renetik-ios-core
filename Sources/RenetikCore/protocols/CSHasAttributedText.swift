//
// Created by Rene Dohan on 11/22/20.
//

import Foundation
import UIKit

public protocol CSHasAttributedTextProtocol: AnyObject {
    func attributedText() -> NSAttributedString?
    func attributed(text: NSAttributedString?)
}


extension UITextView: CSHasAttributedTextProtocol {
    public func attributedText() -> NSAttributedString? { attributedText }

    public func attributed(text: NSAttributedString?) { attributedText = text }
}

extension UILabel: CSHasAttributedTextProtocol {
    public func attributedText() -> NSAttributedString? { attributedText }

    public func attributed(text: NSAttributedString?) { attributedText = text }
}

public extension CSHasAttributedTextProtocol
        where Self: UIView, Self: CSHasFontProtocol, Self: CSHasTextColorProtocol {

    @discardableResult
    func html(_ text: String) -> Self { self.text(html: text) }

    @discardableResult
    func text(html text: String) -> Self {
        let html = """
                   <html><body style="color:\(textColor!.hex); 
                                font-family:\(font()!.fontName); 
                                font-size:\(font()!.pointSize);">\(text)</body></html>
                   """
        html.data(using: .utf8, allowLossyConversion: true).notNil { data in
            attributedText = try? NSAttributedString(data: data, options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: NSNumber(value: String.Encoding.utf8.rawValue)
            ], documentAttributes: nil)
        }
        return self
    }
}

extension CSHasAttributedTextProtocol {
    var attributedText: NSAttributedString? {
        get { attributedText() }
        set { attributed(text: newValue) }
    }

    func attributed(text: NSAttributedString?) -> Self { attributed(text: text); return self }
}