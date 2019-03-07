//
//  UIViewController+CSExtension.swift
//  Renetik
//
//  Created by Rene Dohan on 2/19/19.
//

import RenetikObjc
import UIKit

@objc public extension UIViewController {
    @discardableResult
    @objc public func push() -> Self {
        navigation.push(self)
        return self
    }
}

public extension UIViewController {
    public func tableOnLoadList<ListData: CSListData, RowType: AnyObject>(
        _ table: CSTableController<RowType>,
        _ sendRequest: @escaping (Int) -> CSResponse<ListData>) {
        table.onLoad = { pageIndex in
            sendRequest(pageIndex).onSuccess { listData in
                table.onLoadSuccess(listData.list as! [RowType])
            } as! CSResponse<AnyObject>
        }
    }
}
