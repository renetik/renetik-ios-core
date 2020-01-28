//
// Created by Rene Dohan on 12/15/19.
//

import RenetikObjc

public typealias CSTableControllerRow = CSAny & Equatable & CustomStringConvertible
public typealias CSTableControllerParent = CSMainController & UITableViewDataSource & UITableViewDelegate &
                                           CSOperationController & CSHasDialog & CSHasProgress

public class CSTableController<Row: CSTableControllerRow, Data>: CSViewController {

    public var onLoad: (() -> CSOperation<Data>)!
    public let onLoadResponse: CSEvent<CSProcess<Data>> = event()
    public var onUserRefresh: (() -> Bool)?
    public var searchText = "" { didSet { filterDataAndReload() } }
    internal var isLoading = false
    internal var isFailed = false
    internal var failedMessage: String?
    internal var filteredData = [Row]()
    private var loadProcess: CSProcess<Data>? = nil

    internal var parentController: CSTableControllerParent!
    public let tableView = UITableView.construct().also { $0.estimatedRowHeight = 0 }
    private var filter: CSTableControllerFilter?
    internal var data: [Row]!

    public func construct(by parent: CSTableControllerParent,
                          parentView: UIView? = nil, data: [Row] = [Row]()) -> Self {
        parentController = parent
        tableView.set(delegate: parent).hide()
        filter = parentController as? CSTableControllerFilter
        self.data = data
        parentController.showChild(controller: self, parentView: parentView ?? parent.view)
        return self
    }

    override public func loadView() { view = tableView }

    override public func onViewWillAppearFromPresentedController() {
        super.onViewWillAppearFromPresentedController()
        tableView.reloadData()
    }

    public override func onViewWillTransition(toSizeCompletion size: CGSize,
                                              _ context: UIViewControllerTransitionCoordinatorContext) {
        tableView.reloadData()
    }

    public var dataCount: Int { filteredData.count }

    @discardableResult
    public func reload(withProgress: Bool = true) -> CSProcess<Data> {
        if isLoading { loadProcess!.cancel() }
        isLoading = true
        return parentController.send(operation: onLoad(), progress: withProgress, failedDialog: false)
                .onFailed { process in
                    self.isFailed = true
                    self.failedMessage = process.message
                    self.tableView.reloadData()
                }.onCancel { process in
                    self.isFailed = true
                    self.failedMessage = process.message
                    self.tableView.reloadData()
                }.onDone { data in
                    self.isLoading = false
                }.also { process in
                    self.loadProcess = process
                    onLoadResponse.fire(process)
                }
    }

    @discardableResult
    public func load(_ array: [Row]) -> Self {
        data.reload(array)
        filterDataAndReload()
        isFailed = false
        tableView.fadeIn()
        return self
    }

    public func load(add dataToAdd: [Row]) {
        data.add(array: dataToAdd)
        let filteredDataToAdd = filter(data: dataToAdd)
        var paths = [IndexPath]()
        for index in 0..<filteredDataToAdd.count {
            paths.add(IndexPath(row: index + dataCount, section: 0))
        }
        self.filteredData.add(array: filteredDataToAdd)
        tableView.beginUpdates()
        tableView.insertRows(at: paths, with: .automatic)
        tableView.endUpdates()
        isFailed = false
    }

    private func filter(data: [Row]) -> [Row] {
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
    public func register<CellType: UITableViewCell>(cell type: CellType.Type) -> Self {
        tableView.register(cell: type)
        return self
    }

    public func dequeue<CellType: UITableViewCell>(
            cell type: CellType.Type, onCreate function: ((CellType) -> Void)? = nil) -> CellType {
        tableView.dequeue(cell: type, onCreate: function)
    }
}

