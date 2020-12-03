//
// Created by Rene Dohan on 12/1/20.
//

import Foundation

open class CSJsonArray: CSObject, CSJsonArrayProtocol {
    var index = 0
    fileprivate var data = [CSAnyProtocol?]()

    public required override init() { // This is for instantiating by reflection ?
        super.init()
    }

    @discardableResult
    func load(data: [String: CSAnyProtocol?]) -> Self {
        self.data.add(data)
        return self
    }

    public var asArray: [Any?] { data }

    func at(_ key: Int) -> CSAnyProtocol? { data[key] }

    func add(_ value: CSAnyProtocol?) -> CSAnyProtocol? { data.add(value) }

    public override var description: String { super.description }
}

extension CSJsonArray: Sequence {
    public func makeIterator() -> IndexingIterator<[CSAnyProtocol?]> { data.makeIterator() }
}