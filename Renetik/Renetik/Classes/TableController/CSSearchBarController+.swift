//
// Created by Rene Dohan on 12/17/19.
//

import UIKit
import RenetikObjc

public extension CSSearchBarController {

    @discardableResult
    public func construct<Row: CSTableControllerRow, Data>(
            _ parent: CSViewController,
            placeHolder: String = .searchPlaceholder,
            table: CSTableController<Row, Data>,
            filter: CSTableFilter<Row, Data> = CSContainsIgnoreCaseTableFilter<Row, Data>()) -> Self {
        table.filter = filter
        construct(by: parent, placeHolder: placeHolder) { string in
            filter.searchText = string
            table.filterDataAndReload()
        }
        return self
    }
}