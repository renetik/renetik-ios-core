//
//  CSSelectNameController.swift
//  Renetik
//
//  Created by Rene Dohan on 2/20/19.
//

import RenetikObjc

@objc public class CSSelectNameController: CSMainController
    , UITableViewDelegate, UITableViewDataSource {
    @objc public let table = UITableView.construct()
    @objc public let search = UISearchBar.construct()
    @objc public var selectedRow: CSName?
    private var names: [CSName] = []
    private var filteredData: [CSName] = []
    private var onSelected: ((CSName?) -> Void)!
    private var onDelete: ((CSName) -> CSResponse<AnyObject>)?
    private var deleteTitle = ""

    @objc public func construct(
        names: [CSName],
        _ onSelected: @escaping (CSName?) -> Void) -> Self {
        self.names = names
        self.onSelected = onSelected
        return self
    }

    @objc public func construct(
        data: CSListData,
        _ onSelected: @escaping (CSName?) -> Void) -> Self {
        return construct(names: data.list as! [CSName], onSelected)
    }

    @objc public func construct(
        names: [CSName], _ onSelected: @escaping (CSName?) -> Void,
        _ clearTitle: String) -> Self {
        construct(names: names, onSelected)
        menuItem(title: clearTitle, onClick: onClearClick)
        return self
    }

    public func construct(
        strings: [String], _ onSelected: @escaping (Int?) -> Void,
        _ clearTitle: String) -> Self {
        construct(names: CSName.createNames(fromStrings: strings),
                  { name in onSelected(name?.index) }, clearTitle)
        return self
    }

    @objc public func construct(
        names: [CSName], _ onSelected: @escaping (CSName?) -> Void,
        _ deleteTitle: String,
        _ onDelete: @escaping (CSName) -> CSResponse<AnyObject>) -> Self {
        construct(names: names, onSelected)
        self.onDelete = onDelete
        self.deleteTitle = deleteTitle
        menuItem(type: .edit) {
            $0.systemItem =
                self.table.toggleEditing().isEditing ? .cancel : .edit
        }
        return self
    }

    @objc public func construct(
        data: CSListData, _ onSelected: @escaping (CSName?) -> Void,
        _ deleteTitle: String,
        _ onDelete: @escaping (CSName) -> CSResponse<AnyObject>) -> Self {
        construct(names: data.list as! [CSName], onSelected,
                  deleteTitle, onDelete)
        return self
    }

    public func construct<T: AnyObject>(
        data: CSListData, _ onSelected: @escaping (CSName?) -> Void,
        _ deleteTitle: String,
        _ onDelete: @escaping (CSName) -> CSResponse<T>) -> Self {
        return construct(data: data, onSelected, deleteTitle,
                         onDelete as! ((CSName) -> CSResponse<AnyObject>))
    }

    public override func onViewWillAppear() {
        super.onViewWillAppear()
        view.add(view: table).matchParent()
        table.hideEmptyCellSplitterBySettingEmptyFooter()
        table.allowsMultipleSelectionDuringEditing = false
        table.tableHeaderView = search
        table.delegate = self
        table.dataSource = self
        CSSearchBarController()
            .construct(self, search) { _ in self.reload() }
        reload()
    }

    private func onClearClick(_ item: CSMenuItem) {
        selectedRow = nil
        onSelected!(selectedRow)
        navigation.popViewController()
    }

    private func reload() {
        filteredData = names.filter(bySearch: search.text)
        table.reloadData()
    }

    public func tableView(_ tableView: UITableView,
                          cellForRowAt path: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(with: "Cell", style: .default)
        cell.textLabel?.text = filteredData[path.row].name
        return cell
    }

    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    public func tableView(_ tableView: UITableView,
                          didSelectRowAt path: IndexPath) {
        selectedRow = filteredData[path.row]
        navigation.popViewController()
        onSelected!(selectedRow)
    }

    public func tableView(_ tableView: UITableView,
                          canEditRowAt path: IndexPath) -> Bool {
        return onDelete.notNil
    }

    public func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCell.EditingStyle,
                          forRowAt path: IndexPath) {
        if editingStyle == .delete {
            let value = filteredData[path.row]
            onDelete?(value).onSuccess { _ in
                self.names.remove(value)
                if self.names.isEmpty { navigation.popViewController() }
                else { self.reload() }
            }
        }
    }
}
