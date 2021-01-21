//
//  CSSelectNameController.swift
//  Renetik
//
//  Created by Rene Dohan on 2/20/19.
//

import Renetik
import RenetikObjc

public class CSNameChooserController<RowType: CSNameRowType>: CSMainController
        , UITableViewDelegate, UITableViewDataSource {

    public let table = UITableView.construct()
    public let search = CSSearchBarController()
    public var selectedName: RowType?
    private var names: [RowType] = []
    private var filteredData: [RowType] = []
    private var onSelected: ((RowType) -> Void)!
    private var onDelete: ((RowType) -> CSResponseProtocol)?

    private var editMenuItem: CSMenuItem? = nil

    @discardableResult
    public func construct(data: [RowType], onSelected: @escaping (RowType) -> Void) -> Self {
        self.names = data
        self.onSelected = onSelected
        return self
    }

    @discardableResult
    public func add(onDelete: @escaping (RowType) -> CSResponseProtocol) -> Self {
        self.onDelete = onDelete
        editMenuItem.isNil {
            self.editMenuItem = menu(type: .edit) {
                $0.systemItem = self.table.toggleEditing().isEditing ? .cancel : .edit
            }
        }
        return self
    }

    public override func onViewDidLayoutFirstTime() {
        super.onViewDidLayoutFirstTime()
        view.add(view: table).matchParent()
        table.hideEmptySeparatorsByEmptyFooter()
        table.allowsMultipleSelectionDuringEditing = false
        table.tableHeaderView = search.bar
        table.delegates(self)
        search.construct(by: self) { _ in self.reload() }
        reload()
    }

    private func reload() {
        filteredData = names.filter(bySearch: search.text)
        table.reload()
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
            onDelete?(value).onSuccess {
                self.names.remove(value)
                if self.names.isEmpty { navigation.popViewController() } else { self.reload() }
            }
        }
    }
}
