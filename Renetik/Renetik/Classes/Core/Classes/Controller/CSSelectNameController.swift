//
//  CSSelectNameController.swift
//  Renetik
//
//  Created by Rene Dohan on 2/20/19.
//

import RenetikObjc

public class CSSelectNameController: CSMainController, UITableViewDelegate, UITableViewDataSource {

    public let table = UITableView.construct()
    public let search = CSSearchBarController()
    public var selectedName: CSName?
    private var names: [CSName] = []
    private var filteredData: [CSName] = []
    private var onSelected: ((CSName) -> Void)!
    private var onDelete: ((CSName) -> CSResponse<AnyObject>)?

    @discardableResult
    public func construct(data: [CSName], onSelected: @escaping (CSName) -> Void) -> Self {
        self.names = data
        self.onSelected = onSelected
        return self
    }

    @discardableResult
    public func addDelete<T: AnyObject>(_ onDelete: @escaping (CSName) -> CSResponse<T>) -> Self {
        self.onDelete = onDelete as! ((CSName) -> CSResponse<AnyObject>)
        menu(type: .edit) { $0.systemItem = self.table.toggleEditing().isEditing ? .cancel : .edit }
        return self
    }

    public override func onViewWillAppear() {
        super.onViewWillAppear()
        view.add(view: table).matchParent()
        table.hideEmptyCellsSeparatorByEmptyFooter()
        table.allowsMultipleSelectionDuringEditing = false

        search.construct(by: self) { _ in self.reload() }
        table.tableHeaderView = search.bar

        table.delegates(self)
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
                          numberOfRowsInSection section: Int) -> Int {
        filteredData.count
    }

    public func tableView(_ tableView: UITableView,
                          didSelectRowAt path: IndexPath) {
        selectedName = filteredData[path.row]
        navigation.popViewController()
        onSelected!(selectedName!)
    }

    public func tableView(_ tableView: UITableView,
                          canEditRowAt path: IndexPath) -> Bool {
        onDelete.notNil
    }

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
