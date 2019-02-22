//
//  CSSelectNameController.swift
//  Renetik
//
//  Created by Rene Dohan on 2/20/19.
//

import RenetikObjc

@objc public class CSSelectNameController: CSMainController, UITableViewDelegate, UITableViewDataSource {
    @objc public var table: UITableView!
    @objc public var search: UISearchBar!
    @objc public var selectedRow: CSName?
    @objc public var primaryColor: UIColor?
    @objc public var secondaryColor: UIColor?
    @objc public var backgroundColor: UIColor?
    private var names: [CSName] = []
    private var filteredData: [CSName] = []
    private var onSelected: ((CSName?) -> Void)?
    private var onDelete: ((CSName) -> CSResponse<AnyObject>)?
    private var deleteTitle = ""

    @objc public func construct(data: CSListData,
                                _ onSelected: @escaping (CSName?) -> Void) -> Self {
        return construct(names: data.list() as! [CSName], onSelected)
    }

    @objc public func construct(data: CSListData,
                                _ onSelected: @escaping (CSName?) -> Void,
                                _ deleteTitle: String,
                                _ onDelete: @escaping (CSName) -> CSResponse<AnyObject>) -> Self {
        construct(data: data, onSelected)
        self.onDelete = onDelete
        self.deleteTitle = deleteTitle
        menuItem(nil, type: UIBarButtonItem.SystemItem.edit).onClick { item in
            item.systemItem = self.table!.toggleEditing().isEditing ? .cancel : .edit
        }
        return self
    }

    @objc public func construct(names: [CSName],
                                _ onSelected: @escaping (CSName?) -> Void) -> Self {
        self.names = names
        filteredData = self.names
        self.onSelected = onSelected
        return self
    }

    @objc public func construct(names: [CSName],
                                _ onSelected: @escaping (CSName?) -> Void,
                                _ clearTitle: String) -> Self {
        construct(names: names, onSelected)
        menuItem(clearTitle) { _ in
            self.onClearClick()
        }
        return self
    }

    public func construct(strings: [String],
                          _ onSelected: @escaping (Int?) -> Void,
                          _ clearTitle: String) -> Self {
        construct(names: CSName.createNames(fromStrings: strings),
                  { name in onSelected(name?.index) }, clearTitle)
        return self
    }

    @objc public func construct(names: [CSName],
                                _ onSelected: @escaping (CSName?) -> Void,
                                _ deleteTitle: String,
                                _ onDelete: @escaping (CSName) -> CSResponse<AnyObject>) -> Self {
        construct(names: names, onSelected)
        self.onDelete = onDelete
        self.deleteTitle = deleteTitle
        menuItem(nil, type: UIBarButtonItem.SystemItem.edit).onClick { item in
            item.systemItem = self.table!.toggleEditing().isEditing ? .cancel : .edit
        }
        return self
    }

    public override func loadView() {
        table = UITableView.withSize(100, 100)
        view = table
        search = UISearchBar.withSize(100, 40)
        table.tableHeaderView = search
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        table.setupTable(self)
            .hideEmptyCellSplitterBySettingEmptyFooter()
            .allowsMultipleSelectionDuringEditing = false
        CSSearchBarController().construct(self, search) { _ in self.reload() }
    }

    func onClearClick() {
        onSelected?(selectedRow)
        selectedRow = nil
        navigation.popViewController()
    }

    @objc public func setData(_ names: [CSName]) -> Self {
        self.names = names
        table.reloadData()
        return self
    }

    func onFilterData(_ searchText: String?) {
        reload()
    }

    public func tableView(_ tableView: UITableView, cellForRowAt path: IndexPath) -> UITableViewCell {
        let cell = tableView.getCellWithStyle("Cell", .default)
        cell.textLabel?.textColor = secondaryColor
        cell.textLabel?.text = filteredData[path.row].name
        return cell
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt path: IndexPath) {
        selectedRow = filteredData[path.row]
        navigation.popViewController()
        onSelected?(selectedRow)
    }

    func tableView(_ tableView: UITableView,
                   editActionsForRowAt path: IndexPath) -> [UITableViewRowAction]? {
        if onDelete.notNil {
            let delete = UITableViewRowAction(style: .destructive,
                                              title: deleteTitle, handler: onDeleteAction)
            delete.backgroundColor = primaryColor
            return [delete]
        }
        return nil
    }

    func onDeleteAction(_ action: UITableViewRowAction, _ path: IndexPath) {
        let value = filteredData[path.row]
        onDelete?(value).onSuccess { _ in
            self.names.remove(value)
            self.reload()
        }
    }

    @objc public func reload() {
        filteredData = names.filter(bySearch: search.text)
        table.reloadData()
    }
}
