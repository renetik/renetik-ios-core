open class CSJsonArray: CSObject, CSJsonArrayProtocol {
    fileprivate var array = [CSAnyProtocol]()

    // This is for instantiating by reflection ?
    public required override init() {
        super.init()
    }

    @discardableResult
    public func load(data: [CSAnyProtocol]) -> Self {
        array = data
        return self
    }

    public var asArray: [Any?] { array }

    public func at(_ key: Int) -> CSAnyProtocol? { array[key] }

    public func add(_ value: CSAnyProtocol?) -> CSAnyProtocol? { array.add(value) }
}

extension CSJsonArray: Sequence {
    public func makeIterator() -> IndexingIterator<[CSAnyProtocol]> { array.makeIterator() }
}