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
public typealias CSTableControllerParentType =
        CSMainController & CSViewControllerProtocol & UITableViewDataSource & UITableViewDelegate

public class CSTableController<RowType: CSTableControllerRowType>: CSViewController {

    public var onLoad: (() -> CSResponse<AnyObject>)!
    public let onLoadResponse: CSEvent<CSResponse<AnyObject>> = event()
    public var onUserRefresh: (() -> Bool)?
    public var searchText = "" { didSet { filterDataAndReload() } }
    internal var isLoading = false
    internal var isFailed = false
    internal var failedMessage = ""
    internal var filteredData = [RowType]()
    private var loadResponse: CSResponse<AnyObject>? = nil

    internal var parentController: (UIViewController & CSViewControllerProtocol)!
    public let tableView = UITableView.construct().also { $0.estimatedRowHeight = 0 }
    private var filter: CSTableControllerFilter?
    internal var data: [RowType]!

    public func construct(by parent: CSTableControllerParentType,
                          parentView: UIView? = nil, data: [RowType] = [RowType]()) -> Self {
        parentController = parent
        tableView.delegates(parent).hide()
        filter = parentController as? CSTableControllerFilter
        self.data = data
        parentController.showChild(controller: self, parentView: parentView ?? parent.view)
        return self
    }

    @discardableResult
    public func onLoadList(request: @escaping () -> CSResponse<CSListData>) -> Self {
        onLoad = {
            request().onSuccess { data in self.load(data.list.cast()) }.cast()
        }
        return self
    }

    override public func loadView() { view = tableView }

    override public func onViewWillAppearFromPresentedController() {
        super.onViewWillAppearFromPresentedController()
        tableView.reloadData()
    }

    public var dataCount: Int { filteredData.count }

    @discardableResult
    public func reload() -> CSResponse<AnyObject> { reload(withProgress: true) }

    @discardableResult
    public func reload(withProgress: Bool) -> CSResponse<AnyObject> {
        if isLoading { loadResponse!.cancel() }
        isLoading = true
        let loadResponse = onLoad()
        if withProgress { parentController.show(progress: loadResponse) }
        loadResponse.onFailed { response in
            self.isFailed = true
            self.failedMessage = response.message
            self.tableView.reloadData()
        }
        loadResponse.onCancel { response in
            self.isFailed = true
            self.failedMessage = response.message
            self.tableView.reloadData()
        }
        loadResponse.onDone { data in
            self.tableView.fadeIn()
//            self.refreshControl?.endRefreshing()
            self.isLoading = false
        }
        self.loadResponse = loadResponse
        onLoadResponse.fire(loadResponse)
        return loadResponse
    }

    @discardableResult
    public func load(_ array: [RowType]) -> Self {
        data.reload(array)
        filterDataAndReload()
        isFailed = false
        return self
    }

    public func load(add toAddData: [RowType]) {
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
        isFailed = false
    }

    private func filter(data: [RowType]) -> [RowType] {
        let filteredBySearchData = data.filter(bySearch: searchText)
        return filter?.filter(data: filteredBySearchData) ?? filteredBySearchData
    }

    internal func filterDataAndReload() {
        filteredData.reload(filter(data: data))
        tableView.reloadData()
        filter?.onReloadDone(in: self)
    }
}

extension CSTableController {
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
