//
//  CSSelectNameController.swift
//  Renetik
//
//  Created by Rene Dohan on 2/20/19.
//

import Renetik
import RenetikObjc

public class CSNameChooserController<T: Any>: CSMainController
        , UITableViewDelegate, UITableViewDataSource {

    public let table = UITableView.construct()
    public let search = CSSearchBarController()
    public var selectedName: CSNameJsonData?
    private var names: [CSNameJsonData] = []
    private var filteredData: [CSNameJsonData] = []
    private var onSelected: ((CSNameJsonData) -> Void)!
    private var onDelete: ((CSNameJsonData) -> CSProcess<T>)?
    private var editMenuItem: CSMenuItem? = nil

    @discardableResult
    public func construct(data: [CSNameJsonData], onSelected: @escaping (CSNameJsonData) -> Void) -> Self {
        self.names = data
        self.onSelected = onSelected
        return self
    }

    @discardableResult
    public func add(onDelete: @escaping (CSNameJsonData) -> CSProcess<T>) -> Self {
        self.onDelete = onDelete
        editMenuItem.isNil {
            self.editMenuItem = menuItem(type: .edit) {
                $0.systemItem = self.table.toggleEditing().isEditing ? .cancel : .edit
            }
        }
        return self
    }

    public override func onCreateLayout() {
        super.onCreateLayout()
        view.add(view: table).matchParent()
        table.hideEmptyCellSplitterBySettingEmptyFooter()
        table.allowsMultipleSelectionDuringEditing = false
        table.tableHeaderView = search.bar
        table.delegate = self
        table.dataSource = self
        search.construct(by: self) { _ in self.reload() }
        reload()
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
                          numberOfRowsInSection section: Int) -> Int { filteredData.count }

    public func tableView(_ tableView: UITableView,
                          didSelectRowAt path: IndexPath) {
        selectedName = filteredData[path.row]
        navigation.popViewController()
        onSelected!(selectedName!)
    }

    public func tableView(_ tableView: UITableView,
                          canEditRowAt path: IndexPath) -> Bool { onDelete.notNil }

    public func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCell.EditingStyle,
                          forRowAt path: IndexPath) {
        if editingStyle == .delete {
            let value = filteredData[path.row]
            onDelete?(value).onSuccess { _ in
                self.names.remove(value)
                if self.names.isEmpty { navigation.popViewController() } else { self.reload() }
            }
        }
    }
}
