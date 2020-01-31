//
//  CSTableListDataLoader.swift
//
//  Created by Rene Dohan on 3/8/19.
//

import UIKit
import RenetikObjc

public extension CSTableController {

    public func data(for path: IndexPath) -> Row { filteredData[path.row] }

    public func add(item: Row) {
        data.add(item)
        filterDataAndReload()
    }

    public func insert(item: Row, index: Int) {
        data.insert(item, at: index)
        filterDataAndReload()
    }

    public func remove(item: Row) {
        data.remove(item)
        filterDataAndReload()
    }

    public func remove(item index: Int) {
        data.remove(at: index)
        filterDataAndReload()
    }

    public func clear() {
        data.removeAll()
        filteredData.removeAll()
        tableView.reload()
    }
}
