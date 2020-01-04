//
// Created by Rene Dohan on 12/4/19.
// Copyright (c) 2019 Bowbook. All rights reserved.
//

import Renetik

public class CSServerJsonData: CSJsonData {
    open var success: Bool { getBoolean("success") ?? false }
    open var message: String? { getString("message") }
}

public class CSListServerJsonData<ListItem: CSJsonData>: CSServerJsonData {
    var key: String!
    var type: ListItem.Type!
    var property: CSJsonDataList<ListItem>!

    public func construct(_ key: String, _ type: ListItem.Type) -> Self {
        construct()
        self.key = key
        self.type = type
        property = CSJsonDataList(self, type, key)
        return self
    }

    public func construct(_ type: ListItem.Type) -> Self { construct("list", type) }

    public var list: [ListItem] { property.list }
}
