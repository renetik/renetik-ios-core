//
// Created by Rene Dohan on 12/4/19.
// Copyright (c) 2019 Bowbook. All rights reserved.
//

import Renetik

public extension CSJsonObject {
    func put(_ key: String, _ value: String?) { put(key: key, value: value) }

    func put(_ key: String, _ value: Int?) { put(key: key, value: value) }

    func put(_ key: String, _ value: Bool?) { put(key: key, value: value) }

    func put(_ key: String, _ value: CSJsonObjectProtocol) { put(key: key, value: value.asDictionary) }

    func put(_ key: String, _ value: CSJsonArrayProtocol) { put(key: key, value: value.asArray) }

    func put(_ key: String, _ value: [Any?]) { put(key: key, value: value) }

    func put(_ key: String, _ value: [String: Any?]) { put(key: key, value: value) }
}

