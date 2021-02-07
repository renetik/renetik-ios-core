//
// Created by Rene Dohan on 12/9/19.
// Copyright (c) 2019 Renetik. All rights reserved.
//

import RenetikObjc
import Renetik

extension CSJsonObject {
    func createJsonDataList<T: CSJsonObject>(_ type: T.Type, _ key: String, defaultDataList: [T]? = nil) -> [T] {
        let mapDataArray: [[String: CSAnyProtocol?]]? = getList(key)
        var jsonDataArray: [T] = [T]()
        mapDataArray?.enumerated().forEach { index, item in
            jsonDataArray.add(type.init().load(data: item, index: index))
        }
        return jsonDataArray
    }
}