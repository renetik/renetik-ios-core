//
// Created by Rene Dohan on 11/22/20.
//

import Foundation
import UIKit

public protocol CSHasAttributedTextProtocol: AnyObject {
    func attributedText() -> NSAttributedString?
    func attributed(text: NSAttributedString?) -> Self
}

extension UIButton: CSHasAttributedTextProtocol {
    public func attributedText() -> NSAttributedString? {
        attributedTitle(for: .normal)
    }

    public func attributed(text: NSAttributedString?) -> Self {
        setAttributedTitle(text, for: .normal); return self
    }
}

extension UITextView: CSHasAttributedTextProtocol {
    public func attributedText() -> NSAttributedString? { attributedText }

    public func attributed(text: NSAttributedString?) -> Self { attributedText = text; return self }
}

extension UILabel: CSHasAttributedTextProtocol {
    public func attributedText() -> NSAttributedString? { attributedText }

    public func attributed(text: NSAttributedString?) -> Self { attributedText = text; return self }
}

public extension CSHasAttributedTextProtocol
        where Self: CSHasFontProtocol, Self: CSHasTextColorProtocol {
    @discardableResult
    func html(_ text: String) -> Self { self.text(html: text) }

    @discardableResult
    func text(html text: String) -> Self {
        let html = """
                   <html><body style="color:\(textColor!.hexValue()!); 
                                font-family:\(font()!.fontName); 
                                font-size:\(font()!.pointSize);">\(text)</body></html>
                   """
        html.data(using: .unicode, allowLossyConversion: true).notNil { data in
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
}