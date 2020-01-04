//
// Created by Rene Dohan on 12/15/19.
//

import RenetikObjc

public typealias CSTableControllerRow = CSJsonData
public typealias CSTableControllerParent = CSMainController & UITableViewDataSource & UITableViewDelegate

public class CSTableController<RowType: CSTableControllerRow>: CSViewController {

    public var onLoad: ((_ withProgress: Bool) -> CSProcess<AnyObject>)!
    public let onLoadResponse: CSEvent<CSProcess<AnyObject>> = event()
    public var onUserRefresh: (() -> Bool)?
    public var searchText = "" { didSet { filterDataAndReload() } }
    internal var isLoading = false
    internal var isFailed = false
    internal var failedMessage: String?
    internal var filteredData = [RowType]()
    private var loadProcess: CSProcess<AnyObject>? = nil

    internal var parentController: CSTableControllerParent!
    public let tableView = UITableView.construct().also { $0.estimatedRowHeight = 0 }
    private var filter: CSTableControllerFilter?
    internal var data: [RowType]!

    public func construct(by parent: CSTableControllerParent,
                          parentView: UIView? = nil, data: [RowType] = [RowType]()) -> Self {
        parentController = parent
        tableView.delegates(parent).hide()
        filter = parentController as? CSTableControllerFilter
        self.data = data
        parentController.showChild(controller: self, parentView: parentView ?? parent.view)
        return self
    }

    @discardableResult
    public func onLoadList(operation: CSOperation<CSListServerJsonData<RowType>>) -> Self {
        onLoad = { isProgress in operation.send(progress: isProgress) { data in self.load(data.list) }.cast() }
        return self
    }

    override public func loadView() { view = tableView }

    override public func onViewWillAppearFromPresentedController() {
        super.onViewWillAppearFromPresentedController()
        tableView.reloadData()
    }

    public var dataCount: Int { filteredData.count }

    @discardableResult
    public func reload(withProgress: Bool = true) -> CSProcess<AnyObject> {
        if isLoading { loadProcess!.cancel() }
        isLoading = true
        return onLoad(withProgress).onFailed { process in
            self.isFailed = true
            self.failedMessage = process.errorMessage
            self.tableView.reloadData()
        }.onCancel { process in
            self.isFailed = true
            self.failedMessage = process.errorMessage
            self.tableView.reloadData()
        }.onDone { data in
            self.isLoading = false
        }.also { process in
            self.loadProcess = process
            onLoadResponse.fire(process)
        }
    }

    @discardableResult
    public func load(_ array: [RowType]) -> Self {
        data.reload(array)
        filterDataAndReload()
        isFailed = false
        tableView.fadeIn()
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

