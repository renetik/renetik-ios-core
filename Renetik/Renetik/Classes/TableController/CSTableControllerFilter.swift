//
// Created by Rene Dohan on 1/2/20.
//

import Foundation
import UIKit
import RenetikObjc

public protocol CSTableControllerFilter {
    func filter<ObjectType>(data: [ObjectType]) -> [ObjectType]?
    func onReloadDone<ObjectType>(in controller: CSTableController<ObjectType>)
}

extension CSTableControllerFilter {
    func filter<ObjectType>(data: [ObjectType]) -> [ObjectType] { data }

    func onReloadDone<ObjectType>(in controller: CSTableController<ObjectType>) {}
}