//
// Created by Rene Dohan on 31/05/22.
//

import Foundation

class UserDefaultsStore: CSStore, Sequence {

    let defaults = UserDefaults.standard
    let eventChanged: CSEvent<CSStore> = event()
    var data: [String: Any?] { defaults.dictionaryRepresentation() }

    func clear() { data.keys.forEach { key in clear(key: key) } }

    func clear(key: String) { defaults.removeObject(forKey: key) }

    func has(key: String) -> Boolean { defaults.value(forKey: key).notNil }

    func set(key: String, value: String?) {
        defaults.set(value, forKey: key)
        eventChanged.fire(self)
    }

    func get(key: String) -> String? { defaults.string(forKey: key) }

    func set(key: String, value: [String: CSAnyProtocol]?) {
        set(key: key, value: value?.toJsonString(formatted: isDebug))
    }

    func getMap(key: String) -> [String: CSAnyProtocol]? {
        get(key: key)?.parseJson() as? [String: CSAnyProtocol]
    }

    func set(key: String, value: [CSAnyProtocol]?) {
        set(key: key, value: value?.toJsonString(formatted: isDebug))
    }

    func getArray(key: String) -> [CSAnyProtocol]? {
        get(key: key)?.parseJson() as? [CSAnyProtocol]
    }

    func set<T>(key: String, value: T?) where T: CSJsonObject {
        set(key: key, value: value?.toJsonString(formatted: isDebug))
    }

    func getJsonObject<T>(key: String, type: T.Type) -> T? where T: CSJsonObject {
        getString(key: key)?.parseJsonDictionary()?.ret { type.init().load(data: $0) }
        //getString(key: key)?.parseJsonDictionary()?.ret { type.init().load(data: $0) }
    }

    func load(store: CSStore) {
//        loadAll(store)
        eventChanged.fire(self)
    }

    func reload(store: CSStore) {
        clear()
//        loadAll(store)
        eventChanged.fire(self)
    }
}