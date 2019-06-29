
extension String {
    public func addSizeToHtmlImageTags(_ width: CGFloat) -> String {
        var endTagsToAddSize: Array<Int> = []
        let string = NSMutableString(string: self)
        var startTagIndex = -1
        repeat {
            startTagIndex = string.indexOf("<img ", from: startTagIndex + 1)
            if startTagIndex != NSString.notFound {
                let endTagIndex = string.indexOf("/>", from: startTagIndex + 1)
                if !string.substring(from: startTagIndex, to: endTagIndex).contains("width=") {
                    endTagsToAddSize.append(endTagIndex)
                }
            }
        } while startTagIndex != NSString.notFound

        for endTagIndex in endTagsToAddSize.reversed() {
            string.insert("<br>", at: endTagIndex + 2)
            string.insert(" width='\(Int(width))' height='\(Int(width / 2))' ", at: endTagIndex)
        }
        return string as String
    }

    public func addHtmlTags() -> String {
        if !starts(with: "<html") {
            return "<html><body>\(self)</body></html>"
        }
        return self
    }
}
