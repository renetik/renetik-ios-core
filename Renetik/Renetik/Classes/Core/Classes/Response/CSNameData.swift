//
//  CSName.swift
//  Renetik
//
//  Created by Rene Dohan on 2/20/19.
//

import RenetikObjc

open class CSNameData: CSDictionaryJsonData {
    public var nameKey = "name"
    public var idKey = "id"

    open var name: String {
        get { getStringValue(nameKey) }
        set(value) { put(nameKey, value) }
    }

    open var id: String {
        get { getStringValue(idKey) }
        set(value) { put(idKey, value) }
    }

    public required override init() { super.init() }

    public init(_ name: String, _ id: String = "") {
        super.init()
        self.id = id
        self.name = name
    }

    public class func create(_ name: String, _ id: String = "") -> Self {
        self.init().construct(name, id)
    }

    public class func createNames(fromStrings strings: [String]) -> [CSNameData] {
        var names = [CSNameData]()
        var index = 0
        for name: String in strings {
            names.add(create(name)).index = index
            index += 1
        }
        return names
    }

    public func construct(_ name: String, _ id: String = "") -> Self {
        self.id = id
        self.name = name
        return self
    }

    open override var description: String { name }

    open override func isEqual(_ object: Any?) -> Bool {
        if let nameObject = object as? CSNameData {
            return nameObject.name == name
        }
        return super.isEqual(object)
    }

    public class func find(nameId: String, _ names: [CSNameData]) -> CSNameData? {
        for name: CSNameData in names {
            if name.id.equals(nameId) == true {
                return name
            }
        }
        return nil
    }

    public class func find(name: String, _ names: [CSNameData]) -> CSNameData? {
        for nameObject: CSNameData in names {
            if nameObject.name.equals(name) {
                return nameObject
            }
        }
        return nil
    }
}

//public extension Array where Element: CSName {
//}
