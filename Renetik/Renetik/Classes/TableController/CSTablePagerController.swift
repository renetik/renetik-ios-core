//
// Created by Rene Dohan on 12/25/19.
//

import Foundation
import UIKit
import RenetikObjc

public class CSTablePagerController<RowType: CSTableControllerRow>: NSObject {

    private var table: CSTableController<RowType>!
    private var onLoadPage: ((Int) -> CSProcess<AnyObject>)!
    private var pageIndex = -1
    private var noNext = false
    private var loadNextView: UIView?
    private var loadNextColor: UIColor? = nil

    public var onShouldLoadNext: ((IndexPath) -> Bool)?

    @discardableResult
    public func construct(by controller: CSTableController<RowType>,
                          operation: @escaping (Int) -> CSOperation<CSListServerJsonData<RowType>>) -> Self {
        self.table = controller
        onLoadPage = { index in operation(index).send().onSuccess { data in self.load(data.list) }.cast() }
        table.onLoad = onLoad
        return self;
    }

    public func construct(by controller: CSTableController<RowType>,
                          process: @escaping (Int) -> CSProcess<AnyObject>) -> Self {
        self.table = controller
        onLoadPage = process
        table.onLoad = onLoad
        return self;
    }

    private func onLoad(_ withProgress: Bool) -> CSProcess<AnyObject> {
        noNext = false
        pageIndex = 0
        return onLoadPage(pageIndex)
    }

    @discardableResult
    public func load(_ array: [RowType]) -> Self {
        (pageIndex == 0).then { table.load(array) }.elseDo { table.load(add: array) }
        (array.hasItems).then { pageIndex += 1 }.elseDo { noNext = true }
//        if pageIndex == 0 {
//            table.load(array)
//        } else {
//            table.load(add: array)
//        }
//        if array.hasItems {
//            pageIndex += 1
//        } else {
//            noNext = true
//        }
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
        onLoadPage!(pageIndex).onFailed { _ in
            self.table.parentController.toast(CSStrings.tableLoadNextFailed)
        }.onDone { _ in
            self.table.isLoading = false
            self.loadNextView?.removeFromSuperview()
        }
    }

    private func showLoadNextIndicator() {
        table.tableView.superview!.add(view: loadNextView ?? createLoadNextView())
                .from(bottom: 5).centerInParentHorizontal()
    }

    private func createLoadNextView() -> UIView {
        UIActivityIndicatorView(style: .gray).also { view in
            loadNextColor.notNil { view.color = $0 }
            view.startAnimating()
            self.loadNextView = view
        }
    }
}
