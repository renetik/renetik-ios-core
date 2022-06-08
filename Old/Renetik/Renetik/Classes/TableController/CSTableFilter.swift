//
// Created by Rene Dohan on 1/2/20.
//

import Foundation
import UIKit
import RenetikObjc

open class CSTableFilter<Row: CSTableControllerRow, Data>: CSObject {

    open var searchText = ""

    open func filter(data: [Row]) -> [Row] { data }

    open func onReloadDone(in controller: CSTableController<Row, Data>) {}
}

public class CSSearchNameContainsIgnoreCaseTableFilter<Row: CSTableControllerRow, Data>:
        CSTableFilter<Row, Data> where Row: CSSearchNameProtocol, Row: CustomStringConvertible {
    public override func filter(data: [Row]) -> [Row] { data.filter(bySearch: searchText) }
}

public class CSContainsIgnoreCaseTableFilter<Row: CSTableControllerRow, Data>:
        CSTableFilter<Row, Data> where Row: CustomStringConvertible {
    public override func filter(data: [Row]) -> [Row] { data.filter(bySearch: searchText) }
}