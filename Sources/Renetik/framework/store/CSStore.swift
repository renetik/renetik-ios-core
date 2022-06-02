//
// Created by Rene Dohan on 30/05/22.
//

import Foundation

protocol CSStore: CSPropertyStore, CSJsonObjectInterface {
    var eventChanged: CSEvent<CSStore> { get }
    var data: [String: Any?] { get }
    func has(key: String) -> Boolean
    func bulkSave() -> Closeable

    func set(key: String, value: String?)
    func get(key: String) -> String?

    func set(key: String, value: [String: CSAnyProtocol]?)
    func getMap(key: String) -> [String: CSAnyProtocol]?

    func set(key: String, value: [CSAnyProtocol]?)
    func getArray(key: String) -> [CSAnyProtocol]?

    func getJsonArray<T: CSJsonObject>(key: String, type: T.Type) -> [T]?

    func set<T: CSJsonObject>(key: String, value: T?)
    func getJsonObject<T: CSJsonObject>(key: String, type: T.Type) -> T?

    func load(store: CSStore)
    func reload(store: CSStore)
    func clear()
    func clear(key: String)
}

extension CSStore where Self: Sequence {
    func makeIterator() -> Dictionary<String, Any?>.Iterator {
        data.makeIterator()
    }
}

extension CSStore {
    var asDictionary: [String: Any?] { data }

    func has(key: String) -> Boolean { data.contains { itemKey, _ in itemKey == key } }

    func bulkSave() -> Closeable { Closeable { logWarn("Bulk save not implemented") } }

    func get(key: String) -> String? { data[key]?.asString }

    func reload(store: CSStore) {
        bulkSave().use {
            clear()
            load(store: store)
        }
    }

    func set(key: String, value: Boolean?) { set(key: key, value: value?.asString) }

    func set(key: String, value: Int?) { set(key: key, value: value?.asString) }

    func set(key: String, value: Float?) { set(key: key, value: value?.asString) }

    func set(key: String, value: Double?) { set(key: key, value: value?.asString) }

    func getString(key: String, defaultValue: String) -> String { get(key: key) ?? defaultValue }

    func getString(key: String) -> String? { get(key: key) }

    func getBoolean(key: String, defaultValue: Boolean) -> Boolean { get(key: key)?.boolValue ?? defaultValue }

    func getBoolean(key: String, defaultValue: Boolean? = nil) -> Boolean? { get(key: key)?.boolValue ?? defaultValue }

    func getInt(key: String, defaultValue: Int) -> Int { get(key: key)?.intValue ?? defaultValue }

    func getInt(key: String, defaultValue: Int? = nil) -> Int? { get(key: key)?.intValue ?? defaultValue }

    func getFloat(key: String, defaultValue: Float) -> Float { get(key: key)?.floatValue ?? defaultValue }

    func getFloat(key: String, defaultValue: Float? = nil) -> Float? { get(key: key)?.floatValue ?? defaultValue }

    func getDouble(key: String, defaultValue: Double) -> Double { get(key: key)?.doubleValue ?? defaultValue }

    func getDouble(key: String, defaultValue: Double? = nil) -> Double? { get(key: key)?.doubleValue ?? defaultValue }


//
//    override fun property(key: String, value: String, onChange: ((value: String) -> Unit)?) =
//        CSStringValueStoreEventProperty(this, key, value, listenStoreChanged = false, onChange)
//
//    override fun property(key: String, value: Boolean, onChange: ((value: Boolean) -> Unit)?) =
//        CSBooleanValueStoreEventProperty(this, key, value, onChange)
//
//    override fun property(key: String, value: Int, onChange: ((value: Int) -> Unit)?) =
//        CSIntValueStoreEventProperty(this, key, value, onChange = onChange)
//
//    override fun property(key: String, value: Double, onChange: ((value: Double) -> Unit)?) =
//        CSDoubleValueStoreEventProperty(this, key, value, onChange)
//
//    override fun property(key: String, value: Float, onChange: ((value: Float) -> Unit)?) =
//        CSFloatValueStoreEventProperty(this, key, value, onChange)
//
//    override fun property(key: String, value: Long, onChange: ((value: Long) -> Unit)?) =
//        CSLongValueStoreEventProperty(this, key, value, onChange)
//
//    override fun <T> property(
//        key: String, values: List<T>, value: T, onChange: ((value: T) -> Unit)?) =
//        CSListItemValueStoreEventProperty(this, key, values, value, false, onChange)
//
//    override fun <T> property(
//        key: String, values: List<T>, getDefault: () -> T, onChange: ((value: T) -> Unit)?) =
//        CSListItemValueStoreEventProperty(this, key, { values }, getDefault, false, onChange)
//
//    override fun <T> property(
//        key: String, getValues: () -> List<T>,
//        defaultIndex: Int, onChange: ((value: T) -> Unit)?
//    ) = CSListItemValueStoreEventProperty(this, key, getValues,
//        { getValues()[defaultIndex] }, listenStoreChanged = false, onChange)
//
//    override fun <T : CSHasId> property(
//        key: String, values: Iterable<T>, value: List<T>, onChange: ((value: List<T>) -> Unit)?) =
//        CSListValueStoreEventProperty(this, key, values, value, onChange)
//
//    fun <T : CSJsonObject> CSStore.lateProperty(
//        key: String, listType: KClass<T>, onApply: ((value: List<T>) -> Unit)? = null
//    ) = CSJsonListLateStoreEventProperty(this, key, listType, onApply)
//
//    fun lateStringProperty(key: String, onChange: ((value: String) -> Unit)? = null) =
//        CSStringLateStoreEventProperty(this, key, onChange)
//
//    fun lateIntProperty(key: String, onChange: ((value: Int) -> Unit)? = null) =
//        CSIntLateStoreEventProperty(this, key, onChange)
//
//    override fun lateBoolProperty(key: String, onChange: ((value: Boolean) -> Unit)?) =
//        CSBooleanLateStoreEventProperty(this, key, onChange)
//
//    fun <T> lateItemProperty(key: String, values: List<T>,
//                             onChange: ((value: T) -> Unit)? = null) =
//        CSValuesItemLateStoreEventProperty(this, key, values, onChange)
//
//    override fun nullBoolProperty(key: String, default: Boolean?,
//                                  onChange: ((value: Boolean?) -> Unit)?) =
//        CSBooleanNullableStoreEventProperty(this, key, default, onChange)
//
//    override fun propertyNullInt(key: String, default: Int?, onChange: ((value: Int?) -> Unit)?) =
//        CSIntNullableStoreEventProperty(this, key, default, onChange)
//
//    override fun <T> propertyNullListItem(
//        key: String, values: List<T>, default: T?, onChange: ((value: T?) -> Unit)?) =
//        CSListItemNullableStoreEventProperty(this, key, values, default, onChange)
//}
}

extension CSStore {
    func getJsonArray<T>(key: String, type: T.Type) -> [T]? where T: CSJsonObject {
        //TODO BUG!!!!
        let mapDataArray = get(key: key) as? [[String: CSAnyProtocol?]]
        var jsonObjectArray: [T] = [T]()
        mapDataArray?.enumerated().forEach { index, item in
            jsonObjectArray.add(type.init().load(data: item, index: index))
        }
        return jsonObjectArray
    }


}