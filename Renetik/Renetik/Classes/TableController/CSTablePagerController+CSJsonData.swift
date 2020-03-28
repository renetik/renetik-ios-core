//
// Created by Rene Dohan on 1/9/20.
//

import Foundation
import RenetikObjc

public extension CSTablePagerController where Row: CSJsonData, Data: CSListServerJsonData<Row> {
    @discardableResult
    public func construct(by controller: CSTableController<Row, Data>,
                          operation: @escaping (Int) -> CSOperation<Data>) -> Self {
        self.table = controller
        onLoadPage = { index in operation(index).onSuccess { data in self.load(data.list) } }
        table.loadData = onLoad
        return self
    }
}

public extension CSTablePagerController where Data: CSListData {
    @discardableResult
    public func construct(using controller: CSTableController<Row, Data>,
                          request: @escaping (Int) -> CSOperation<Data>) -> Self {
        self.table = controller
        onLoadPage = { index in request(index).onSuccess { data in self.load(data.list.cast()) } }
        table.loadData = onLoad
        return self
    }
}