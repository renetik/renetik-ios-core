//
// Created by Rene Dohan on 12/4/19.
// Copyright (c) 2019 Renetik. All rights reserved.
//

import Renetik

open class CSJsonObject: CSObject, CSJsonObjectProtocol {

    private(set) public var index: Int? = nil
    private(set) public var data = [String: CSAnyProtocol?]()

    public required override init() { // This is for instantiating by reflection ?
        super.init()
    }

    @discardableResult
    public func load(data: [String: CSAnyProtocol?], index: Int? = nil) -> Self {
        self.data.add(data)
        self.index = index
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