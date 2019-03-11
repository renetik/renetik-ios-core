//
//  CSTableListDataLoader.swift
//
//  Created by Rene Dohan on 3/8/19.
//

import RenetikObjc
import UIKit

@objc public class CSTableListDataLoader: NSObject {
	@discardableResult
	public init<ListData: CSListData, RowType: AnyObject>(
		_ table: CSTableController<RowType>,
		_ sendRequest: @escaping (Int) -> CSResponse<ListData>) {
		table.onLoad = { pageIndex in
			sendRequest(pageIndex).onSuccess { listData in
				table.load(listData.list as! [RowType])
				} as! CSResponse<AnyObject>
		}
	}
	
	@objc public func construct(_ table: CSTableController<AnyObject>,
								_ sendRequest: @escaping (Int) -> CSResponse<CSListData>) {
		table.onLoad = { pageIndex in
			sendRequest(pageIndex).onSuccess { listData in
				table.load(listData.list as! [AnyObject])
				} as! CSResponse<AnyObject>
		}
	}
}

