//
//  CSTableListDataLoader.swift
//
//  Created by Rene Dohan on 3/8/19.
//

import UIKit
import RenetikObjc

@objc public class CSTableListDataLoader: NSObject {
    @discardableResult
    public init<ListData: CSListData, RowType: AnyObject>(
            _ table: CSTableController<RowType>,
            _ sendRequest: @escaping (Int) -> CSResponse<ListData>) {
        table.onLoadPage { pageIndex in
            sendRequest(pageIndex)
                    .onSuccess { listData in table.load(listData.list as! [RowType]) }
                    as! CSResponse<AnyObject>
        }
    }

    @discardableResult
    public init<ListData: CSListData, RowType: AnyObject>(
            _ table: CSTableController<RowType>,
            _ sendRequest: @escaping () -> CSResponse<ListData>) {
        table.onLoad {
            sendRequest()
                    .onSuccess { listData in table.load(listData.list as! [RowType]) }
                    as! CSResponse<AnyObject>
        }
    }

    @objc public func load(_ table: CSTableController<AnyObject>,
                           _ sendRequest: @escaping () -> CSResponse<CSListData>) {
        table.onLoad {
            sendRequest()
                    .onSuccess { listData in table.load(listData.list as! [AnyObject]) }
                    as! CSResponse<AnyObject>
        }
    }

    @objc public func loadPages(_ table: CSTableController<AnyObject>,
                                _ sendRequest: @escaping (Int) -> CSResponse<CSListData>) {
        table.onLoadPage { pageIndex in
            sendRequest(pageIndex)
                    .onSuccess { listData in table.load(listData.list as! [AnyObject]) }
                    as! CSResponse<AnyObject>
        }
    }
}
