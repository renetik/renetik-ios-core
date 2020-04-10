//
// Created by Rene Dohan on 4/10/20.
//

import Foundation
import RenetikObjc

public extension String {

    public func htmlToText(_ encoding: String.Encoding) -> String? {
        if let data = data(using: encoding) {
            return (try? NSAttributedString(data: data,
                    options: [.documentType: NSAttributedString.DocumentType.html],
                    documentAttributes: nil))?.string
        }
        return nil
    }

    public func replaceTagWithEmptySpace(startTag: String, endTag: String) -> Self {
        let string = NSMutableString(string: self)
        var startTagIndex: Int? = -1
        repeat {
            startTagIndex = index(of: startTag, from: startTagIndex! + 1)
            if startTagIndex.notNil {
                index(of: endTag, from: startTagIndex! + 1).notNil { endTagIndex in
                    let endTagIndex = endTagIndex + endTag.length
                    string.replaceCharacters(in: NSRange(startTagIndex! ..< endTagIndex),
                            with: String(repeating: " ", count: endTagIndex - startTagIndex!))
                    startTagIndex = endTagIndex
                }.elseDo { startTagIndex = size - 1 }
            }
        } while startTagIndex.notNil
        return string as String
    }

}
