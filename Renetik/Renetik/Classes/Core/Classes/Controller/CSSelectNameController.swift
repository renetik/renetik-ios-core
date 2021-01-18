//
//  CSSelectNameController.swift
//  Renetik
//
//  Created by Rene Dohan on 2/20/19.
//

import RenetikObjc

public typealias CSNameRowType = CSNameProtocol & CustomStringConvertible & Equatable

public class CSSelectNameController<Data: CSNameRowType>:
        CSMainController, UITableViewDelegate, UITableViewDataSource {

    public let table = UITableView.construct()
    public let search = CSSearchBarController()
    public var onCellCreate: ((UITableViewCell) -> Void)? = nil
    public var selectedName: Data?
    private var names: [Data] = []
    private var filteredData: [Data] = []
    private var onSelected: ((Data) -> Void)!
    private var onDelete: ((Data) -> CSResponseProtocol)?

    @discardableResult
    public func construct(data: [Data], onSelected: @escaping (Data) -> Void) -> Self {
        self.names = data
        self.onSelected = onSelected
        return self
    }

    @discardableResult
    public func addDelete<T: AnyObject>(_ onDelete: @escaping (Data) -> CSResponse<T>) -> Self {
        self.onDelete = onDelete
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
        tableView.cell(style: .default, onCreate: onCellCreate)
                .also { $0.textLabel!.text = filteredData[path.row].name }
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
            onDelete?(value).onSuccess {
                self.names.remove(value)
                if self.names.isEmpty { navigation.popViewController() } else { self.reload() }
            }
        }
    }
}
