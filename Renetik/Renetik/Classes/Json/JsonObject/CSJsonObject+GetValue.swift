//
// Created by Rene Dohan on 12/9/19.
// Copyright (c) 2019 Bowbook. All rights reserved.
//

import RenetikObjc
import Renetik

public extension CSJsonObject {
    func getStringValue(_ key: String) -> String { getString(key).asString }

    func getBooleanValue(_ key: String) -> Bool { getBoolean(key) ?? false }
}