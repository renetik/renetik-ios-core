//
// Created by Rene Dohan on 12/9/19.
// Copyright (c) 2019 Bowbook. All rights reserved.
//

import RenetikObjc
import Renetik

extension CSJsonData {
    func createJsonDataList<T: CSJsonData>(_ type: T.Type, _ key: String, defaultDataList: [T]? = nil) -> [T] {
        let mapDataArray: [[String: CSAnyProtocol?]]? = getList(key)
        var jsonDataArray: [T] = [T]()
        mapDataArray?.enumerated().forEach { index, item in
            jsonDataArray.add(type.init().construct().load(data: item).also { $0.index = index })
        }
        return jsonDataArray
    }
}