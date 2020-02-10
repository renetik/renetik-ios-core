extension String {
    public func addSizeToHtmlImageTags(_ width: CGFloat) -> String {
        var endTagsToAddSize: Array<Int> = []
//        var string = String(self)
        let string = NSMutableString(string: self)
        var startTagIndex = -1
        repeat {
            startTagIndex = string.index(of: "<img ", from: startTagIndex + 1)
            if startTagIndex != NSString.notFound {
                let endTagIndex = string.index(of: "/>", from: startTagIndex + 1)
                let tagSubString = string.substring(from: startTagIndex, to: endTagIndex)
                if !tagSubString.contains("width=") {
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
