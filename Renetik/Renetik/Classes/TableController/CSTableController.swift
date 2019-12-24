//
// Created by Rene Dohan on 12/15/19.
//

import RenetikObjc

public protocol CSTableControllerFilter {
    func filter<ObjectType>(data: [ObjectType]) -> [ObjectType]?
    func onReloadDone<ObjectType>(in controller: CSTableController<ObjectType>)
}

extension CSTableControllerFilter {
    func filter<ObjectType>(data: [ObjectType]) -> [ObjectType] { data }

    func onReloadDone<ObjectType>(in controller: CSTableController<ObjectType>) {}
}

public typealias CSTableControllerRowType = AnyObject & CustomStringConvertible & Equatable
public typealias CSTableControllerParentType = CSMainController & CSViewControllerProtocol &
                                               UITableViewDataSource & UITableViewDelegate

public class CSTableController<RowType: CSTableControllerRowType>: CSViewController {

    public let tableView = UITableView.construct().also { $0.estimatedRowHeight = 0 }
    var onUserRefresh: (() -> Bool)?
    public var searchText = "" { didSet { filterDataAndReload() } }
    var onShouldLoadNext: ((IndexPath) -> Bool)?
    var loadNextView: UIView?
    var isLoading = false
    var isFailed = false
    var failedMessage = ""
    var pageIndex = -1
    private var parentController: (UIViewController & CSViewControllerProtocol)!
    private(set) var data: [RowType]!
    private var filteredData = [RowType]()
    private var filter: CSTableControllerFilter?
    private var noNext = false
    private var loadResponse: CSResponse<AnyObject>? = nil
    private var loadNextColor: UIColor? = nil
    var refreshControl: CSRefreshControl?
    public var onLoad: (() -> CSResponse<AnyObject>)?
    public var onLoadPage: ((Int) -> CSResponse<AnyObject>)?

    public func construct(by parent: CSTableControllerParentType,
                          parentView: UIView, data: [RowType]) -> Self {
        self.parentController = parent
        tableView.delegates(parent).hide()
        filter = parentController as? CSTableControllerFilter
        self.data = data
        parentController.showChild(controller: self, parentView: parentView)
        return self
    }

    public func construct(by parent: CSTableControllerParentType, data: [RowType]) -> Self {
        construct(by: parent, parentView: parent.view, data: data)
    }

    public func construct(by parent: CSTableControllerParentType, parentView: UIView) -> Self {
        construct(by: parent, parentView: parentView, data: [RowType]())
    }

    public func construct(by parent: CSTableControllerParentType) -> Self {
        construct(by: parent, data: [RowType]())
    }

    override public func loadView() { view = tableView }

    public func refreshable() -> Self {
        refreshControl = CSRefreshControl().construct(tableView) {
            self.onUserRefresh.notNil { onUserRefresh in
                if onUserRefresh() { self.reload(withProgress: false) }
            }.elseDo { self.reload(withProgress: false) }
        }
        return self
    }

    override public func onViewWillTransition(toSizeCompletion size: CGSize,
                                              _ context: UIViewControllerTransitionCoordinatorContext?) {
        tableView.reloadData()
    }

    override public func onViewWillAppearFromPresentedController() {
        super.onViewWillAppearFromPresentedController()
        tableView.reloadData()
    }

    @discardableResult
    public func reload() -> CSResponse<AnyObject> { reload(withProgress: true) }

    @discardableResult
    public func reload(withProgress: Bool) -> CSResponse<AnyObject> {
        if isLoading { loadResponse!.cancel() }
        noNext = false
        pageIndex = -1
        isLoading = true
        loadResponse = onLoad.notNil ? onLoad!() : onLoadPage!(0)
        if withProgress { parentController.showProgress(loadResponse!) }
        loadResponse!.onFailed { response in
            self.isFailed = true
            self.failedMessage = response.message
            self.tableView.reloadData()
        }
        loadResponse!.onCancel { response in
            self.isFailed = true
            self.failedMessage = response.message
            self.tableView.reloadData()
        }
        return loadResponse!.onDone { data in
            self.tableView.fadeIn()
            self.refreshControl?.endRefreshing()
            self.isLoading = false
        }
    }

    func loadNext() {
        if onLoadPage.isNil { return }
        if isLoading { return }
        isLoading = true
        showLoadNextIndicator()
        parentController.showFailed(onLoadPage!(pageIndex + 1)).onDone { data in
            self.isLoading = false
            self.loadNextView?.removeFromSuperview()
        }
    }

    @discardableResult
    public func load(_ array: [RowType]) -> Self {
        if pageIndex == -1 {
            data.reload(array)
            filterDataAndReload()
        }
        else {
            load(add: array)
        }
        if array.hasItems {
            pageIndex += 1
        }
        else {
            noNext = true
        }
        isFailed = false
        return self
    }

    func load(add toAddData: [RowType]) {
        data.add(array: toAddData)
        let toAddFilteredData = filter(data: toAddData)
        var paths = [IndexPath]()
        for index in 0..<toAddFilteredData.count {
            paths.add(IndexPath(row: index + dataCount, section: 0))
        }
        self.filteredData.add(array: toAddFilteredData)
        tableView.beginUpdates()
        tableView.insertRows(at: paths, with: .automatic)
        tableView.endUpdates()
    }

    func showLoadNextIndicator() {
        if loadNextView.isNil {
            let loadingNextView = UIActivityIndicatorView(style: .gray)
            loadNextColor.notNil { loadingNextView.color = $0 }
            loadingNextView.startAnimating()
            loadNextView = loadingNextView
        }
        tableView.superview!.add(view: loadNextView!).from(bottom: 5).centerInParentHorizontal()
    }

    public func tableViewWillDisplayCellForRow(at indexPath: IndexPath) {
        if shouldLoadNext(path: indexPath) { loadNext() }
    }

    private func shouldLoadNext(path: IndexPath) -> Bool {
        if isLoading { return false }
        var loadStartIndex = 5
        if UIScreen.isPortrait && UIDevice.isTablet { loadStartIndex = 10 }
        if UIScreen.isLandscape && UIDevice.isTablet { loadStartIndex = 9 }
        if UIScreen.isPortrait && UIDevice.isPhone { loadStartIndex = 8 }
        if UIScreen.isLandscape && UIDevice.isPhone { loadStartIndex = 7 }
        let pathInPositionForLoadNext = path.row >= dataCount - loadStartIndex
        return !noNext && pathInPositionForLoadNext && (onShouldLoadNext?(path) ?? true)
    }

    private func filter(data: [RowType]) -> [RowType] {
        let filteredBySearchData = data.filter(bySearch: searchText)
        return filter?.filter(data: filteredBySearchData) ?? filteredBySearchData
    }

    private func filterDataAndReload() {
        filteredData.reload(filter(data: data))
        tableView.reloadData()
        filter?.onReloadDone(in: self)
    }

    public func add(item: RowType) {
        data.add(item)
        filterDataAndReload()
    }

    public func insert(item: RowType, index: Int) {
        data.insert(item, at: index)
        filterDataAndReload()
    }

    public func remove(item: RowType) {
        data.remove(item)
        filterDataAndReload()
    }

    public func removeItem(at index: Int) {
        data.remove(at: index)
        filterDataAndReload()
    }

    public func data(for path: IndexPath) -> RowType { filteredData[path.row] }

    public var dataCount: Int { filteredData.count }

    public func clear() {
        data.removeAll()
        filteredData.removeAll()
        tableView.reloadData()
    }

    @discardableResult
    public func scrollToBottom() -> Self {
        if filteredData.hasItems {
            Renetik.doLater {
                let path = IndexPath(row: self.dataCount - 1, section: 0)
                self.tableView.scrollToRow(at: path, at: .bottom, animated: true)
            }
        }
        return self
    }

    public func isAtBottom() -> Bool {
        let lastPath = tableView.indexPathsForVisibleRows?.last
        if lastPath == nil { return true }
        if lastPath!.row == dataCount - 1 { return true }
        return false
    }
}

extension CSTableController {
    @discardableResult
    public func onLoadList(request: @escaping () -> CSResponse<CSListData>) -> Self {
        onLoad = {
            request().onSuccess { data in self.load(data.list.cast()) }.cast()
        }
        return self
    }

    @discardableResult
    public func onLoadListPage(request: @escaping (_ pageIndex: Int) -> CSResponse<CSListData>) -> Self {
        onLoadPage = { pageIndex in
            request(pageIndex).onSuccess { data in self.load(data.list.cast()) }.cast()
        }
        return self
    }
}
