public class CSNameJsonData: CSJsonObject {
    var nameKey: String!

    public func construct(_ nameKey: String) -> Self {
        self.nameKey = nameKey
        return self
    }

    public func construct() -> Self { construct("name") }

    public var id: String { getStringValue("id") }

    public var name: String { getStringValue(nameKey) }

    public var description: String { name }
}
