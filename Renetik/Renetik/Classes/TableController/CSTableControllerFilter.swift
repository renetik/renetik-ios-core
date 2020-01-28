//
// Created by Rene Dohan on 1/2/20.
//

import Foundation
import UIKit
import RenetikObjc

public protocol CSTableControllerFilter {
    func filter<ObjectType>(data: [ObjectType]) -> [ObjectType]?
    func onReloadDone<Row>(in controller: CSTableController<Row, Data>)
}

public extension CSTableControllerFilter {
    func filter<ObjectType>(data: [ObjectType]) -> [ObjectType] { data }
    func onReloadDone<Row, Data>(in controller: CSTableController<Row, Data>) {}
}