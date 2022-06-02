//
// Created by Rene Dohan on 12/9/19.
// Copyright (c) 2019 Renetik. All rights reserved.
//


import Foundation

public extension CSJsonObject {
    func getStringValue(_ key: String) -> String { getString(key).asString }

    func getBooleanValue(_ key: String) -> Bool { getBoolean(key) ?? false }
}