//
// Created by Rene Dohan on 2/1/21.
//

import Foundation

public extension UserDefaults {
    class func load(_ key: String, _  defaultValue: String) -> String {
        UserDefaults.standard.string(forKey: key) ?? defaultValue
    }

    class func load(key: String, default defaultValue: String) -> String {
        UserDefaults.standard.string(forKey: key) ?? defaultValue
    }

    class func load(_ key: String) -> String? { UserDefaults.standard.string(forKey: key) }

    class func load(key: String) -> String? { UserDefaults.standard.string(forKey: key) }

    class func save(_ key: String, _ value: Any?) { UserDefaults.standard.set(value, forKey: key) }

    class func save(key: String, value: Any?) { UserDefaults.standard.set(value, forKey: key) }
}