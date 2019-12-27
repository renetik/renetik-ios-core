//
// Created by Rene Dohan on 12/25/19.
//

import Foundation
import UIKit
import RenetikObjc

public class CSTablePagerController<RowType: CSTableControllerRowType>: NSObject {

    private var table: CSTableController<RowType>!
    private var onLoadPage: ((Int) -> CSResponse<AnyObject>)!
    private var pageIndex = -1
    private var noNext = false
    private var loadNextView: UIView?
    private var loadNextColor: UIColor? = nil

    public var onShouldLoadNext: ((IndexPath) -> Bool)?

    @discardableResult
    public func construct(by controller: CSTableController<RowType>,
                          request: @escaping (Int) -> CSResponse<CSListData>) -> Self {
        self.table = controller
        onLoadPage = { index in request(index).onSuccess { data in self.load(data.list.cast()) }.cast() }
        table.onLoad = onLoad
        return self;
    }

    public func construct(by controller: CSTableController<RowType>,
                          request: @escaping (Int) -> CSResponse<AnyObject>) -> Self {
        self.table = controller
        onLoadPage = request
        table.onLoad = onLoad
        return self;
    }

//    @discardableResult
//    public func onLoadListPage(request: @escaping (Int) -> CSResponse<CSListData>) -> Self {
//        onLoadPage = { index in request(index).onSuccess { data in self.load(data.list.cast()) }.cast() }
//        return self
//    }

    private func onLoad() -> CSResponse<AnyObject> {
        noNext = false
        pageIndex = 0
        return onLoadPage(pageIndex)
    }

    @discardableResult
    public func load(_ array: [RowType]) -> Self {
        if pageIndex == 0 {
            table.load(array)
        }
        else {
            table.load(add: array)
        }
        if array.hasItems {
            pageIndex += 1
        }
        else {
            noNext = true
        }
        return self
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt path: IndexPath) {
        if shouldLoadNext(path: path) { loadNext() }
    }

    private func shouldLoadNext(path: IndexPath) -> Bool {
        if table.isLoading { return false }
        var loadStartIndex = 5
        if UIScreen.isPortrait && UIDevice.isTablet { loadStartIndex = 10 }
        if UIScreen.isLandscape && UIDevice.isTablet { loadStartIndex = 9 }
        if UIScreen.isPortrait && UIDevice.isPhone { loadStartIndex = 8 }
        if UIScreen.isLandscape && UIDevice.isPhone { loadStartIndex = 7 }
        let pathInPositionForLoadNext = path.row >= table.dataCount - loadStartIndex
        return !noNext && pathInPositionForLoadNext && (onShouldLoadNext?(path) ?? true)
    }

    private func loadNext() {
        if table.isLoading { return }
        table.isLoading = true
        showLoadNextIndicator()
        table.parentController.show(failed: onLoadPage!(pageIndex)).onDone { data in
            self.table.isLoading = false
            self.loadNextView?.removeFromSuperview()
        }
    }

    private func showLoadNextIndicator() {
        if loadNextView.isNil {
            let loadingNextView = UIActivityIndicatorView(style: .gray)
            loadNextColor.notNil { loadingNextView.color = $0 }
            loadingNextView.startAnimating()
            loadNextView = loadingNextView
        }
        table.tableView.superview!.add(view: loadNextView!).from(bottom: 5).centerInParentHorizontal()
    }
}
