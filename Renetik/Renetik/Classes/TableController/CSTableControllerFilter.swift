//
// Created by Rene Dohan on 1/2/20.
//

import Foundation
import UIKit
import RenetikObjc

open class CSTableControllerFilter<Row: CSTableControllerRow, Data> {
    open func filter(data: [Row]) -> [Row] { data }

    open func onReloadDone(in controller: CSTableController<Row, Data>) {}
}

//public protocol CSTableControllerFilter {
//    func filter<Row>(data: [Row]) -> [Row]?
//    func onReloadDone<Row>(in controller: CSTableController<Row, Data>)
//}

//public extension CSTableControllerFilter {
//    func filter(data: [Row]) -> [Row] { data }
//    func onReloadDone<Row, Data>(in controller: CSTableController<Row, Data>) {}
//}