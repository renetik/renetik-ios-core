public extension UITableView {
    @discardableResult
    func reloadKeepSelection() -> Self {
        let paths = indexPathsForSelectedRows
        reload()
        paths?.forEach { path in selectRow(at: path, animated: false, scrollPosition: .none) }
        return self
    }

    @discardableResult
    func register<CellType: UITableViewCell>(cell type: CellType.Type) -> Self {
        register(type, forCellReuseIdentifier: type.className())
        return self
    }

    @discardableResult
    func toggleEditing(animated: Bool = true) -> Self {
        setEditing(!isEditing, animated: animated)
        return self
    }

    /*
    * This triggers table reload !!!
    */
    @discardableResult
    func hideEmptySeparatorsByEmptyFooter() -> Self {
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        return self
    }

    func deselectSelectedRow(animated: Bool = true) {
        indexPathForSelectedRow?.also { path in deselectRow(at: path, animated: animated) }
    }

    func deselectSelectedRows(animated: Bool = true) {
        for path in indexPathsForSelectedRows ?? [] { deselectRow(at: path, animated: animated) }
    }

    func dequeueCellWith(identifier: String?) -> UITableViewCell? {
        dequeueReusableCell(withIdentifier: identifier ?? "")
    }

    @discardableResult
    func reload() -> Self {
        reloadData()
        return self
    }

    @discardableResult
    func set<View: UIView>(header view: View) -> View {
        tableHeaderView = view
        return view
    }

    @discardableResult
    func set(footer view: UIView?) -> UIView? {
        tableFooterView = view
        return view
    }

    @discardableResult
    func delegates(_ delegates: UITableViewDelegate & UITableViewDataSource) -> Self {
        delegate = delegates
        dataSource = delegates
        return self
    }

    @discardableResult
    func header<View: UIView>(_ view: View) -> View { tableHeaderView = view; return view }

    var contentHeight: CGFloat {
        let lastFooterRect = rectForFooter(inSection: lastSection)
        return lastFooterRect.origin.y + lastFooterRect.size.height
    }

    var lastSection: Int {
        var lastSection = numberOfSections - 1
        while lastSection > 0 && numberOfRows(inSection: lastSection) <= 0 {
            lastSection -= 1
        }
        return lastSection
    }
}
