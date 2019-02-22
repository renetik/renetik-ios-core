//
//  CSName.swift
//  Renetik
//
//  Created by Rene Dohan on 2/20/19.
//

import RenetikObjc

@objc open class CSName: CSDictionaryJsonData {
    @objc public var nameKey = "name"
    @objc public var idKey = "id"

    @objc open var name: String {
        get { return getStringValue(nameKey) }
        set(value) { put(nameKey, value) }
    }

    @objc open var id: String {
        get { return getStringValue(idKey) }
        set(value) { put(idKey, value) }
    }

    @objc public required override init() {
        super.init()
    }

    public init(_ name: String, _ id: String = "") {
        super.init()
        self.id = id
        self.name = name
    }

    @objc public class func create(_ name: String, _ id: String = "") -> Self {
        return self.init().construct(name, id)
    }

    @objc public class func createNames(fromStrings strings: [String]) -> [CSName] {
        var names = [CSName]()
        var index = 0
        for name: String in strings {
            names.add(create(name)).index = index
            index += 1
        }
        return names
    }

    @objc public func construct(_ name: String, _ id: String = "") -> Self {
        self.id = id
        self.name = name
        return self
    }

    @objc open override var description: String {
        return name
    }

    @objc open override func isEqual(_ object: Any?) -> Bool {
        if let nameObject = object as? CSName {
            return nameObject.name == name
        }
        return super.isEqual(object)
    }

    @objc public class func find(nameId: String, _ names: [CSName]) -> CSName? {
        for name: CSName in names {
            if name.id.equals(nameId) == true {
                return name
            }
        }
        return nil
    }

    @objc public class func find(name: String, _ names: [CSName]) -> CSName? {
        for nameObject: CSName in names {
            if nameObject.name.equals(name) {
                return nameObject
            }
        }
        return nil
    }
}
