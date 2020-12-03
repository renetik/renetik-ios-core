//
// Created by Rene Dohan on 12/4/19.
// Copyright (c) 2019 Bowbook. All rights reserved.
//

import Renetik

open class CSJsonObject: CSObject, CSJsonObjectProtocol {

    var index = 0
    fileprivate var data = [String: CSAnyProtocol?]()

    public required override init() { // This is for instantiating by reflection ?
        super.init()
    }

    @discardableResult
    public func load(data: [String: CSAnyProtocol?]) -> Self {
        self.data.add(data)
        return self
    }

    public var asDictionary: [String: Any?] { data }

    func get(key: String) -> CSAnyProtocol? { data[key] }

    func put(key: String, value: CSAnyProtocol?) -> CSAnyProtocol? { data[key] }
}

extension CSJsonObject: Sequence {
    public func makeIterator() -> Dictionary<String, CSAnyProtocol?>.Iterator {
        data.makeIterator()
    }
}