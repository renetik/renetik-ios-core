//
// Created by Rene Dohan on 12/4/19.
// Copyright (c) 2019 Renetik. All rights reserved.
//

import Renetik

open class CSJsonObject: CSObject, CSJsonObjectInterface {

    private(set) public var index: Int? = nil
    private(set) public var data = [String: CSAnyProtocol?]()

    // TODO: This is for instantiating by reflection ? Try to remove and explain in comment..
    public required override init() {
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