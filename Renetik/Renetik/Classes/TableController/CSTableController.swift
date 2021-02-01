//
// Created by Rene Dohan on 12/15/19.
//

import RenetikObjc

public typealias CSTableControllerRow = Equatable & CustomStringConvertible
public typealias CSTableControllerParent = CSViewController & UITableViewDataSource & UITableViewDelegate &
                                           CSOperationController & CSHasDialogProtocol & CSHasProgressProtocol

public protocol CSTableControllerProtocol {
    var tableView: UITableView { get }
}

public typealias CSTableControllerType = UIViewController & CSTableControllerProtocol

public class CSTableController<Row: CSTableControllerRow, Data>: CSViewController, CSTableControllerProtocol {

    public var filter: CSTableFilter<Row, Data>?

    public var data: [Row] { filteredData }
    public var loadData: (() -> CSOperation<Data>)!
    public let onLoading: CSEvent<CSOperation<Data>> = event()
    public var isFailed: Bool { loadOperation?.failedProcess.isSet ?? false }
    public var failedMessage: String? { loadOperation?.failedProcess?.message }

    internal (set) public var isLoading = false
    private(set) public var isFirstLoadingDone = false


    public let tableView = UITableView.construct().also { $0.estimatedRowHeight = 0 }

    internal var _data: [Row]!

    private var filteredData = [Row]()
    private var loadOperation: CSOperation<Data>? = nil

    public func construct(by parent: CSTableControllerParent,
                          parentView: UIView? = nil, data: [Row] = [Row]()) -> Self {
        super.construct(parent)
        tableView.delegates(parent)
        filter = (parent as? CSTableFilter)
        _data = data
        parentController!.add(controller: self, to: parentView ?? parent.view)
        view.matchParent().add(view: tableView).matchParent()
        return self
    }

    override public func onViewWillAppearFromPresentedController() {
        super.onViewWillAppearFromPresentedController()
        tableView.reload()
    }

    public override func onViewDidAppearFirstTime() {
        super.onViewDidAppearFirstTime()
        if _data.hasItems { filterDataAndReload() }
    }

    public override func onViewDidTransition(
            to size: CGSize, _ context: UIViewControllerTransitionCoordinatorContext) {
        tableView.reload()
    }

    public var dataCount: Int { filteredData.count }

    @discardableResult
    public func reload(withProgress: Bool = true, refresh: Bool = false) -> CSOperation<Data> {
        if isLoading { loadOperation!.cancel() }
        isLoading = true
        tableView.reload()
        loadOperation = (parentController as! CSTableControllerParent)
                .send(operation: loadData().refresh(refresh), title: "", progress: withProgress, failedDialog: false)
                .onFailed { self.clear() }
                .onDone { [self] data in isLoading = false; isFirstLoadingDone = true; tableView.reload() }
        return loadOperation!
    }

    @discardableResult
    public func load(_ array: [Row]) -> Self {
        _data.reload(array)
        filterDataAndReload()
        tableView.fadeIn()
        return self
    }

    public func load(add dataToAdd: [Row]) {
        _data.add(array: dataToAdd)
        let filteredDataToAdd = filter(data: dataToAdd)
        var paths = [IndexPath]()
        for index in 0..<filteredDataToAdd.count {
            paths.add(IndexPath(row: index + dataCount, section: 0))
        }
        filteredData.add(array: filteredDataToAdd)
        tableView.beginUpdates()
        tableView.insertRows(at: paths, with: .automatic)
        tableView.endUpdates()
    }

    internal func filterDataAndReload() {
        filteredData.reload(filter(data: _data))
        tableView.reload()
        filter?.onReloadDone(in: self)
    }

    private func filter(data: [Row]) -> [Row] { filter?.filter(data: data) ?? data }
}

extension CSTableController {
    public func dequeue<CellType: UITableViewCell>(
            cell type: CellType.Type, onCreate function: ((CellType) -> Void)? = nil) -> CellType {
        tableView.dequeue(cell: type, onCreate: function)
    }
}

